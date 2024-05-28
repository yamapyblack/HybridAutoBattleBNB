import { useState, useEffect } from "react";
import Image from "next/image";
import { units } from "src/lib/data/units";
import { SKILLS } from "src/lib/data/skills";

const EditUnitComponent = ({
  index,
  unitId,
  isSub,
  setDraggedIndex,
  setDroppedIndex,
  handleDoubleClick,
}) => {
  const [showTooltip, setShowTooltip] = useState(false);

  const handleDrop = (e) => {
    console.log("handleDrop", index);
    e.preventDefault();
    setDroppedIndex({ index, isSub });
  };

  const handleDragOver = (e) => {
    e.preventDefault();
  };

  const handleDragStart = (e) => {
    console.log("handleDragStart", index);
    setDraggedIndex({ index, isSub });
    setShowTooltip(false);
  };

  const handleMouseEnter = () => {
    if (unit.skillIds.length > 0) {
      setShowTooltip(true);
    }
  };

  const handleMouseLeave = () => {
    console.log("close");
    setShowTooltip(false);
  };

  if (!unitId) {
    return (
      <div onDrop={handleDrop} onDragOver={handleDragOver}>
        <Image
          src={"/images/cards/card-null.png"}
          alt=""
          width={88}
          height={16}
        />
      </div>
    );
  }

  const unit = units[unitId];

  return (
    <>
      <div
        className="p-2 relative"
        style={{ backgroundImage: `url(/images/cards/card-null.png)` }}
      >
        <div
          draggable
          onDragStart={handleDragStart}
          onDrop={handleDrop}
          onDragOver={handleDragOver}
          onMouseEnter={handleMouseEnter}
          onMouseLeave={handleMouseLeave}
          onDoubleClick={handleDoubleClick}
        >
          <Image
            src={`/images/cards/${unit.imagePath}.png`}
            alt=""
            width={72}
            height={16}
          />
        </div>
        <div className="flex justify-between">
          <div className="w-8 relative">
            <Image
              src="/images/common/attack.png"
              alt=""
              width={28}
              height={28}
            />
            <NumberComponent value={unit.attack} />
          </div>
          <div className="w-8 relative">
            <Image
              src="/images/common/life.png"
              alt=""
              width={28}
              height={28}
            />
            <NumberComponent value={unit.life} />
          </div>
        </div>
        {showTooltip && (
          <div
            className="absolute top-6 left-24 w-32 h-18 bg-darkgray rounded border-white border-solid border text-sm p-1"
            style={{ fontFamily: "Inter" }}
          >
            <p>{SKILLS[unit.skillIds[0]].description}</p>
          </div>
        )}
      </div>
    </>
  );
};

const NumberComponent = ({ value }) => {
  const cellWidth = 24;
  return (
    <div
      style={{
        position: "absolute",
        left: 2,
        top: 3,
        width: cellWidth,
      }}
    >
      <Image
        src={`/images/common/numbers/${value}.png`}
        alt=""
        width={100}
        height={100}
      />
    </div>
  );
};

export default EditUnitComponent;

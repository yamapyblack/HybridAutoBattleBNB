import { scrollSepolia, zkSyncSepoliaTestnet, opBNB } from "wagmi/chains";

const addresses = (chainId: number) => {
  if (chainId === zkSyncSepoliaTestnet.id) {
    return {
      PlasmaBattleAlpha: "0x3979d863D02Ce04fc5B8932537b9f69c402B2911",
    };
  } else if (chainId === scrollSepolia.id) {
    return {
      PlasmaBattleAlpha: "0xc5d0b82039f13Dc44638DF7e706C6c6C96D82281",
    };
  } else if (chainId === opBNB.id) {
    return {
      PlasmaBattleAlpha: "0x15EBaAD8717A6B71116ffAF1E0FD4A3b4DE0F96C",
    };
  } else {
    console.error("chainId is not found");
  }

  // PlasmaBattle: "0xc7Bab26f78A8ac0C573B0670D85c590aF3dD9Fa4",
  // PlasmaBattleAlpha: "0x64Ed7A8E7A953ACAC2BAf78A062eb701adFb51CB", //Scroll sepolia
  // PlasmaBattleAlpha: "0x697d51A566dc63DFF5fA5ddb09E3D792BC6dc2eA", //ZkSync sepolia
  // PlasmaBattleAlpha: "0x3979d863D02Ce04fc5B8932537b9f69c402B2911", //ZkSync sepolia2
};
export default addresses;

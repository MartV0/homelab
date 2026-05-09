{ ... }:
{
  hardware.block.scheduler = {
    "nvme[0-9]*" = "kyber";
    "sd[a-z]" = "bfq";
  };
}

Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA51376E01
	for <lists+linux-spi@lfdr.de>; Sat,  8 May 2021 03:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbhEHBCt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 7 May 2021 21:02:49 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:42906 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229482AbhEHBCt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 7 May 2021 21:02:49 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R701e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=zhangliguang@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UY5aemZ_1620435706;
Received: from 30.225.35.234(mailfrom:zhangliguang@linux.alibaba.com fp:SMTPD_---0UY5aemZ_1620435706)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 08 May 2021 09:01:46 +0800
Subject: Re: [PATCH] spi: set right CS polarity depend on gpiolib
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210507145117.43221-1-zhangliguang@linux.alibaba.com>
 <20210507153009.GB6383@sirena.org.uk>
From:   =?UTF-8?B?5Lmx55+z?= <zhangliguang@linux.alibaba.com>
Message-ID: <2f8c5047-1058-8e01-b0af-06853858bf67@linux.alibaba.com>
Date:   Sat, 8 May 2021 09:01:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210507153009.GB6383@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,
在 2021/5/7 23:30, Mark Brown 写道:
> On Fri, May 07, 2021 at 10:51:17PM +0800, Liguang Zhang wrote:
>> After a kernel upgrade from 4.19 to 5.10, we found that tpm flow control
>> always causes TIMEOUT which caused by wrong CS polarity setting depend
>> on gpiolib.
>>   			if (spi->cs_gpiod)
>>   				/* polarity handled by gpiolib */
>> -				gpiod_set_value_cansleep(spi->cs_gpiod, activate);
>> +				gpiod_set_value_cansleep(spi->cs_gpiod, !enable);
> Whatever is going on here it doesn't seem likely that this is a problem
> in the SPI core given the widespread use of gpiod based chip selects -
> can you provide more explanation of what you're seeing here, how is the
> chip select configured, what is the hardware expectation and what
> actually ends up happening?

The arm platform is  kunpeng-920, detail dsdt information here:

         Device (SPI0)
         {
             Name (_HID, "HISI0173")  // _HID: Hardware ID
             Name (_ADR, Zero)  // _ADR: Address
             Name (_UID, Zero)  // _UID: Unique ID
             Name (RBUF, ResourceTemplate ()
             {
                 GpioIo (Exclusive, PullUp, 0x0000, 0x0000, 
IoRestrictionNone,
                     "\\_SB.GPO1", 0x00, ResourceConsumer, ,
                     )
                     {   // Pin list
                         0x0006
                     }
                 QWordMemory (ResourceConsumer, PosDecode, MinFixed, 
MaxFixed, NonCacheable, ReadWrite,
                     0x0000000000000000, // Granularity
                     0x00000002011A0000, // Range Minimum
                     0x00000002011AFFFF, // Range Maximum
                     0x0000000000000000, // Translation Offset
                     0x0000000000010000, // Length
                     ,, , AddressRangeMemory, TypeStatic)
                 Interrupt (ResourceConsumer, Level, ActiveHigh, 
Exclusive, ,, )
                 {
                     0x000001EB,
                 }
             })
             Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource 
Settings
             {
                 Return (RBUF) /* \_SB_.SPI0.RBUF */
             }

             Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
             {
                 ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* 
Device Properties for _DSD */,
                 Package (0x03)
                 {
                     Package (0x02)
                     {
                         "reg-io-width",
                         0x04
                     },

                     Package (0x02)
                     {
                         "num-cs",
                         One
                     },

                     Package (0x02)
                     {
                         "cs-gpios",
                         Package (0x04)
                         {
                             SPI0,
                             Zero,
                             Zero,
                             Zero
                         }
                     }
                 }
             })
         }

         Scope (SPI0)
         {
             Device (TPM)
             {
                 Name (_ADR, Zero)  // _ADR: Address
                 Name (_CID, Package (0x01)  // _CID: Compatible ID
                 {
                     "SMO0768"
                 })
                 Name (_UID, Zero)  // _UID: Unique ID
                 Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
                 {
                     ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* 
Device Properties for _DSD */,
                     Package (0x00){}
                 })
                 Method (_CRS, 0, NotSerialized)  // _CRS: Current 
Resource Settings
                 {
                     Name (RBUF, ResourceTemplate ()
                     {
                         SpiSerialBusV2 (0x0000, PolarityLow, 
FourWireMode, 0x08,
                             ControllerInitiated, 0x000F4240, 
ClockPolarityLow,
                             ClockPhaseFirst, "\\_SB.SPI0",
                             0x00, ResourceConsumer, , Exclusive,
                             )
                     })
                     Return (RBUF) /* \_SB_.SPI0.TPM_._CRS.RBUF */
                 }

                 Method (_STA, 0, NotSerialized)  // _STA: Status
                 {
                     If ((TPEN == One))
                     {
                         Return (0x0F)
                     }
                     Else
                     {
                         Return (Zero)
                     }
                 }
             }
         }
     }


The problem I meet is:

    tpm_tis_spi_init

        tpm_tis_core_init

             wait_startup     // Timeout is occured, appear every time.

If the modification below done, probe succeed.

gpiod_set_value_cansleep(spi->cs_gpiod, !enable)


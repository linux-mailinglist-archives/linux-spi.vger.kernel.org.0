Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8868925F42F
	for <lists+linux-spi@lfdr.de>; Mon,  7 Sep 2020 09:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgIGHkr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Sep 2020 03:40:47 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:53368 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726780AbgIGHkp (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 7 Sep 2020 03:40:45 -0400
IronPort-SDR: rPn1cRd/eEX2ChUbZdHfcmqtDWHtYIQ+/zYB03TPdjIivKMfHt1TdfcBNJsKAE2TE8u+nOIj2j
 FmTyY3s5hKQ7kPIk5xSDiWakm2Xrt5tZ2gdxj0+T2Vq6G4NF8/hdQ7Sn/LzjoD7UjjB7gr7PzL
 qZ7wG1Ru4ae8hdurw3g1F4MgIh0uN4wuN6OIgWZzv4PqcwWV4OlfNqpoVa0/iT5gT32Xr4D5zy
 QvLp44o75Vw0lp4jjTbYC1Inr31dq3fbawGzrv5mWC0QVK2erNyvOFYmM+WPSL86OqAi/kVyCC
 5EE=
X-IronPort-AV: E=Sophos;i="5.76,401,1592863200"; 
   d="scan'208";a="13749997"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 07 Sep 2020 09:40:43 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 07 Sep 2020 09:40:43 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 07 Sep 2020 09:40:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1599464443; x=1631000443;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TSwqqt0JEO6OBt+5hP/mQTOyO/nsVx84HDInNTIixt4=;
  b=HdgpNyicDxmbcyLSlJMHWyVGAXaPvMZC5hvPB3/ZNtnZCi4FrYvoSo4Y
   JJXJhDdZCx2or/dkIK5sHuHZyRe0fQxBvwobSzKb5wc3quLBuPmJJnC7l
   YTlPYaip6WJYq5SBk8YHYiM2F7R4/g9/zBKEssGX45utFa3BlXBSQSB9W
   dkfMSx6r8Y0BBMPBaHcB0GFY9Zm9mkt2v9kVg9Nyn91zltwBjQMgZ/yNk
   OGWUYkDMOUHIPkFp0+s+W+9MZY7jSsnfVs8G36hXQJEwVGP4KBbmqeQnS
   33JT2EfvEx91I2vpifmDk3nwXVi8hJ9DanV3ClgETWx/6eADjFxuMfoVA
   w==;
IronPort-SDR: +OEbeJXRctPdN4XDynK1c+XTZLfHr6rxf3aiVIa3h92PVL5EysBD80QFxH1If+Luyg3X/vQQei
 606lIQ7AUPA4mMsAaNqIPnNLBomCWbig3Ey4XdA1Fz8MDXKlPuylir6EHG4edpb53N4IdZtr+i
 cgDinTnHtf4CXn2Ia0KA/eAI6vD9uflW6EsnjQoSKYdh9Cp8uSzRZZ/xwML4TE54fnPPyaA8AK
 ADfoud3qoWwHgPG8wFCXwEgMIWhudFi2OLh7vk0rWFhuGqG/HblXkGO5yxujV55E4ZyZP+3Qv0
 KZw=
X-IronPort-AV: E=Sophos;i="5.76,401,1592863200"; 
   d="scan'208";a="13749996"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 07 Sep 2020 09:40:43 +0200
Received: from schifferm-ubuntu4 (unknown [10.117.49.134])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 5BED4280065;
        Mon,  7 Sep 2020 09:40:43 +0200 (CEST)
Message-ID: <6c353fa3cc60e8854404eaedebcebee07b103d7c.camel@ew.tq-group.com>
Subject: Re: (EXT) Re: (EXT) Re: (EXT) Re: [PATCH] spi-imx: remove num-cs
 support, set num_chipselect to 4
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Date:   Mon, 07 Sep 2020 09:40:41 +0200
In-Reply-To: <CAOMZO5DNE9dEqXMN3SkB2Xr_BZ2iFM=LJit0hp1sBCb8Htvr1g@mail.gmail.com>
References: <20200903144028.20416-1-matthias.schiffer@ew.tq-group.com>
         <CAOMZO5DGHoG_8X+fbrGCHR4g=sGdEaF7bYrHbC_2T=aUnfTs8g@mail.gmail.com>
         <e1431dd2653dbffdfec39a2e7167db07836e30ac.camel@ew.tq-group.com>
         <CAOMZO5C7yyA11EOQvU0Fq-uDd5RK-B7WmbtvAy8OtPzfThYXRg@mail.gmail.com>
         <f753882996235439b9ef53747d24382e896dc4e7.camel@ew.tq-group.com>
         <20200904150450.GG4625@sirena.org.uk>
         <CAOMZO5DNE9dEqXMN3SkB2Xr_BZ2iFM=LJit0hp1sBCb8Htvr1g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 2020-09-04 at 12:42 -0300, Fabio Estevam wrote:
> Hi Mark,
> 
> On Fri, Sep 4, 2020 at 12:05 PM Mark Brown <broonie@kernel.org>
> wrote:
> > 
> > On Fri, Sep 04, 2020 at 04:34:43PM +0200, Matthias Schiffer wrote:
> > 
> > > Nevertheless, I don't see why we should deliberately remove the
> > > native
> > > CS support - my understanding was that we try to avoid breaking
> > > changes
> > > to DT interpretation even for unknown/out-of-tree DTS.
> > 
> > Yes, we should try to maintain compatibility for anyone that was
> > using
> > it.
> 
> We are not breaking compatibility.
> 
> Prior to 8cdcd8aeee281 ("spi: imx/fsl-lpspi: Convert to GPIO
> descriptors")  num_chipselect was 1 for all device tree users.
> i.MX board files will be removed, so we don't need to worry about
> them.
> 
> What will cause breakage is to say that the driver supports the
> native
> chip-select.
> 
> I have just done a quick test on an imx6q-sabresd.
> 
> With the original dts that uses cs-gpios the SPI NOR is correctly
> probed:
> 
> [    5.402627] spi-nor spi0.0: m25p32 (4096 Kbytes)
> 
> However, using native chip select with this dts change:
> 
> --- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> @@ -189,7 +189,6 @@
>  };
> 
>  &ecspi1 {
> -       cs-gpios = <&gpio4 9 GPIO_ACTIVE_LOW>;
>         pinctrl-names = "default";
>         pinctrl-0 = <&pinctrl_ecspi1>;
>         status = "okay";
> @@ -506,7 +505,7 @@
>                                 MX6QDL_PAD_KEY_COL1__ECSPI1_MISO     
>    0x100b1
>                                 MX6QDL_PAD_KEY_ROW0__ECSPI1_MOSI     
>    0x100b1
>                                 MX6QDL_PAD_KEY_COL0__ECSPI1_SCLK     
>    0x100b1
> -                               MX6QDL_PAD_KEY_ROW1__GPIO4_IO09      
>    0x1b0b0
> +                               MX6QDL_PAD_KEY_ROW1__ECSPI1_SS0      
>    0x1b0b0
>                         >;
>                 };
> 
> Causes SPI NOR probe to fail:
> 
> [    5.388704] spi-nor spi0.0: unrecognized JEDEC id bytes: 00 00 00
> 00 00 00
> 
> That's why I prefer we do not advertise that we can use the native
> chip-select with this driver.


My rationale here is the following: As broken as the native CS of these
controllers is, it isn't an unreasonable assumption that it is working
fine with *some* devices or for some usecases - after all the support
was implemented at some point, and has existed for a long time now. If
we really want to remove this feature, a deprecation period with a
warning message seems like the proper way to deal with this.

Hypothetically, existing out-of-tree DTS could have used the native CS
with num-cs set to 4. Always setting num_chipselect to 4 ensures that
we don't break such DTS with the num-cs removal.

Kind regards,
Matthias


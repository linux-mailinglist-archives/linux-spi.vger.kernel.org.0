Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B831227F5F
	for <lists+linux-spi@lfdr.de>; Tue, 21 Jul 2020 13:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729640AbgGULzK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Jul 2020 07:55:10 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:37121 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726266AbgGULzJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 Jul 2020 07:55:09 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06LBqjc9003474;
        Tue, 21 Jul 2020 13:54:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=xNrr1r61piExo9Kz7DbvrPtsnAcD5qX24XmH5JBqS0c=;
 b=w2KGdHlczl4xzw9NscNrOKGJxvV0PbaEjONM3oUdazggf33Xoh2UjI305YKL0i1JTdNB
 yFrc+nmM0xKmBKnh4ajALQZUGiJ0ysGLfoZri96As9+PnFYibbP+z3fYE9MPVrHNUQDr
 vefIJ94jPuIeGiTzsfyV4BjYHMLYs5eol2+pHbEFvKUua0vbRgYv13kf50/S3dBi8NW/
 p55Drejqhy9K3RjfYeDWZ4yF9W0epSBIUlq/opU5Xf83x1jX86iEsLXfVwik/QF3t2ri
 Bo8G+CmF9cpAKYbCAopLYaKRRxN20w/yH5orvP/oz3mB94o4QumIoFXRL7PHzlKMPHh6 3g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 32bs6uwpev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jul 2020 13:54:42 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5F16010002A;
        Tue, 21 Jul 2020 13:54:41 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3D2782B728A;
        Tue, 21 Jul 2020 13:54:41 +0200 (CEST)
Received: from lmecxl0912.lme.st.com (10.75.127.50) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 21 Jul
 2020 13:54:40 +0200
Subject: Re: [PATCH v5 0/8] Enable ili9341 and l3gd20 on stm32f429-disco
To:     dillon min <dillon.minfei@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>, <p.zabel@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        linux-clk <linux-clk@vger.kernel.org>
References: <broonie@kernel.org>
 <1590378062-7965-1-git-send-email-dillon.minfei@gmail.com>
 <198ad79c-ab12-55f0-814f-afc454a7e8ef@st.com>
 <CAL9mu0L3ZF5+nh2ENzxnu0f6AAh1ygoWx1bEkS3WkJt8TN7C7Q@mail.gmail.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <d7986a59-1337-ca33-fed0-0b6af458dbbb@st.com>
Date:   Tue, 21 Jul 2020 13:54:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAL9mu0L3ZF5+nh2ENzxnu0f6AAh1ygoWx1bEkS3WkJt8TN7C7Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG8NODE3.st.com (10.75.127.24) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-21_05:2020-07-21,2020-07-21 signatures=0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 7/21/20 12:39 PM, dillon min wrote:
> Hi Alexandre,
> 
> On Tue, Jul 21, 2020 at 5:19 PM Alexandre Torgue
> <alexandre.torgue@st.com> wrote:
>>
>> Hi Dillon
>>
>> On 5/25/20 5:40 AM, dillon.minfei@gmail.com wrote:
>>> From: dillon min <dillon.minfei@gmail.com>
>>>
>>> V5's update based on Mark Brown's suggestion, use 'SPI_MASTER_MUST_RX'
>>> for SPI_SIMPLEX_RX mode on stm32 spi controller.
>>>
>>> V5:
>>> 1 instead of add send dummy data out under SIMPLEX_RX mode,
>>>      add flags 'SPI_CONTROLLER_MUST_TX' for stm32 spi driver
>>> 2 bypass 'SPI_CONTROLLER_MUST_TX' and 'SPI_CONTROLLER_MUST_RX' under
>>> 'SPI_3WIRE' mode
>>>
>>
>> Concerning DT patches, they look goods for me. However I'll merge them
>> when drivers parts will be merged.
>>
>> regards
>> Alex
> This patchset status is :
> dts:
>      ARM: dts: stm32: Add dma config for spi5
>      ARM: dts: stm32: Add pin map for ltdc & spi5 on stm32f429-disco board
>      ARM: dts: stm32: enable ltdc binding with ili9341, gyro l3gd20 on
>        stm32429-disco board
> 
> panel-bindings: Reviewed-by: Rob Herring， need more reviewing to merge
>      dt-bindings: display: panel: Add ilitek ili9341 panel bindings
> 
> clk: Acked-by: Stephen Boyd , need more reviewing to merge
>      clk: stm32: Fix stm32f429's ltdc driver hang in set clock rate,
>        fix duplicated ltdc clock register to 'clk_core' case ltdc's clock
>          turn off by clk_disable_unused()
> 
> drm-panel:  Reviewed-by: Linus Walleij . need more reviewing to merge
>      drm/panel: Add ilitek ili9341 panel driver
> 
> spi-driver: Acked-by: Mark Brown ，merged into mainline
>      spi: stm32: Add 'SPI_SIMPLEX_RX', 'SPI_3WIRE_RX' support for stm32f4
>      spi: flags 'SPI_CONTROLLER_MUST_RX' and 'SPI_CONTROLLER_MUST_TX' can't
>        becoexit with 'SPI_3WIRE' mode
> 
> For ili9341 drivers, it seems to need more time to review, or might be dropped.
> since the drm maintainer might create a new interface to support
> DPI,DBI,DSI in one driver.
> Currently it's under discussion. I will rework the ili9341 driver after that.
> 
> But, we can use the existing "drivers/gpu/drm/tiny/ili9341.c" driver to support
> ili9341 on stm32f429-disco board only using the spi bus. except the
> display refresh performance is not as good as the ltdc interface.
> 
> I can submit a new patch just with dts changed this week for it, if you need.
>


Thanks for this status. I'm close to send my PR for v5.9. There is no 
needs to have an intermediate version (Except you absolutely want it).

Thanks
alex

> Thanks,
> Dillon.
>>
>>
>>
>>> V4:
>>> According to alexandre torgue's suggestion, combine ili9341 and
>>> l3gd20's modification on stm32f429-disco board to one patchset.
>>>
>>> Changes:
>>>
>>> ili9341:
>>>
>>> 1 update ili9341 panel driver according to Linus's suggestion
>>> 2 drop V1's No.5 patch, sumbit new changes for clk-stm32f4
>>> 3 merge l3gd20's change to this patchset
>>>
>>> V3:
>>> 1 merge original tiny/ili9341.c driver to panel/panel-ilitek-ili9341.c
>>>     to support serial spi & parallel rgb interface in one driver.
>>> 2 update ilitek,ili9341.yaml dts binding documentation.
>>> 3 update stm32f429-disco dts binding
>>>
>>> V2:
>>> 1 verify ilitek,ili9341.yaml with make O=../linux-stm32
>>>     dt_binding_check
>>>     DT_SCHEMA_FILES=Documentation/devicetree/bindings/display/panel/
>>>     ilitek,ili9341.yaml
>>>
>>> V1:
>>> 1 add ili9341 drm panel driver
>>> 2 add ltdc, spi5 controller for stm32f429-disco
>>> 3 add ltdc, spi5 pin map for stm32f429-disco
>>> 4 add docs about ili9341
>>> 5 fix ltdc driver loading hang in clk set rate bug
>>>
>>>
>>> L3gd20:
>>> V3:
>>> 1 merge stm32f429-disco dtbs binding with ili9341 part
>>>
>>> V2:
>>> 1 insert blank line at stm32f420-disco.dts line 143
>>> 2 add more description for l3gd20 in commit message
>>>
>>> V1:
>>> 1 enable spi5 controller on stm32f429-disco (dts)
>>> 2 add spi5 pinmap for stm32f429-disco  (dts)
>>> 3 add SPI_SIMPLEX_RX, SPI_3WIRE_RX support for stm32f4
>>>
>>>
>>> dillon min (8):
>>>     ARM: dts: stm32: Add dma config for spi5
>>>     ARM: dts: stm32: Add pin map for ltdc & spi5 on stm32f429-disco board
>>>     ARM: dts: stm32: enable ltdc binding with ili9341, gyro l3gd20 on
>>>       stm32429-disco board
>>>     dt-bindings: display: panel: Add ilitek ili9341 panel bindings
>>>     clk: stm32: Fix stm32f429's ltdc driver hang in set clock rate,
>>>       fix duplicated ltdc clock register to 'clk_core' case ltdc's clock
>>>         turn off by clk_disable_unused()
>>>     drm/panel: Add ilitek ili9341 panel driver
>>>     spi: stm32: Add 'SPI_SIMPLEX_RX', 'SPI_3WIRE_RX' support for stm32f4
>>>     spi: flags 'SPI_CONTROLLER_MUST_RX' and 'SPI_CONTROLLER_MUST_TX' can't
>>>       be     coexit with 'SPI_3WIRE' mode
>>>
>>>    .../bindings/display/panel/ilitek,ili9341.yaml     |   69 ++
>>>    arch/arm/boot/dts/stm32f4-pinctrl.dtsi             |   67 +
>>>    arch/arm/boot/dts/stm32f429-disco.dts              |   48 +
>>>    arch/arm/boot/dts/stm32f429.dtsi                   |    3 +
>>>    drivers/clk/clk-stm32f4.c                          |    7 +-
>>>    drivers/gpu/drm/panel/Kconfig                      |   12 +
>>>    drivers/gpu/drm/panel/Makefile                     |    1 +
>>>    drivers/gpu/drm/panel/panel-ilitek-ili9341.c       | 1301 ++++++++++++++++++++
>>>    drivers/spi/spi-stm32.c                            |   19 +-
>>>    drivers/spi/spi.c                                  |    3 +-
>>>    10 files changed, 1521 insertions(+), 9 deletions(-)
>>>    create mode 100644 Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml
>>>    create mode 100644 drivers/gpu/drm/panel/panel-ilitek-ili9341.c
>>>

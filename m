Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C124216B87F
	for <lists+linux-spi@lfdr.de>; Tue, 25 Feb 2020 05:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728866AbgBYEWv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 24 Feb 2020 23:22:51 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:43034 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728846AbgBYEWv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 24 Feb 2020 23:22:51 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01P4McYq094534;
        Mon, 24 Feb 2020 22:22:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582604558;
        bh=8NLi7cw0d43h3KP2wLcX6Hi+4ea89ZXHogFykOYGuUA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=earoyNgH28VwWk9S7AOl+5+V19RAaxqD54D2fl24aYeO0yOAllab6mwDjUtIU01+w
         UsSXMwoGfJdg7FDrhuEnWWTh8fhgm7Cm6Ph/CIxXOYc2XNAsxSWwgxFwPeatDwTG27
         Iug2Vi58QU3r0TflbskLY+442+39e4i6UDlMP61k=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01P4Mc3B015312
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Feb 2020 22:22:38 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 24
 Feb 2020 22:22:37 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 24 Feb 2020 22:22:37 -0600
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01P4MX6o075757;
        Mon, 24 Feb 2020 22:22:34 -0600
Subject: Re: [PATCH v10 0/2] spi: cadence-quadpsi: Add support for the Cadence
 QSPI controller
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <broonie@kernel.org>
CC:     <robh+dt@kernel.org>, <simon.k.r.goldschmidt@gmail.com>,
        <dinguyen@kernel.org>, <tien.fong.chee@intel.com>, <marex@denx.de>,
        <cheol.yong.kim@intel.com>, <qi-ming.wu@intel.com>
References: <20200219022852.28065-1-vadivel.muruganx.ramuthevar@linux.intel.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <99f7e23f-268d-f32b-086f-4a46fc232ce9@ti.com>
Date:   Tue, 25 Feb 2020 09:53:12 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200219022852.28065-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On 19/02/20 7:58 am, Ramuthevar,Vadivel MuruganX wrote:
[...]
>     CHECK   Documentation/devicetree/bindings/spi/cdns,qspi-nor.example.dt.yaml
> 
> Ramuthevar Vadivel Murugan (2):
>   dt-bindings: spi: Add schema for Cadence QSPI Controller driver
>   spi: cadence-quadpsi: Add support for the Cadence QSPI controller
> 
>  .../devicetree/bindings/spi/cdns,qspi-nor.yaml     | 147 +++++
>  drivers/mtd/spi-nor/Kconfig                        |  11 -
>  drivers/mtd/spi-nor/Makefile                       |   1 -
>  drivers/spi/Kconfig                                |   8 +
>  drivers/spi/Makefile                               |   1 +
>  .../spi-cadence-quadspi.c}                         | 641 ++++++++++-----------
>  6 files changed, 459 insertions(+), 350 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml

You will have to remove old bindings as well. Also please CC linux-mtd
list as these patches touch drivers/mtd/*

Just run scripts/get_maintainer.pl on your patches to get list of
mailing list and people to CC

>  rename drivers/{mtd/spi-nor/cadence-quadspi.c => spi/spi-cadence-quadspi.c} (73%)
> 

-- 
Regards
Vignesh

Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33F1C338AFB
	for <lists+linux-spi@lfdr.de>; Fri, 12 Mar 2021 12:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbhCLLHn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 12 Mar 2021 06:07:43 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60036 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233641AbhCLLHW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 12 Mar 2021 06:07:22 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12CB7BTr067919;
        Fri, 12 Mar 2021 05:07:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615547231;
        bh=ppnSwE3fKaBg0neIztuqXvH2QrPjE/AfI+3qNHSV6wo=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=REHTjEo5aenRX8Q/huU1uf1giLvZ2+sOJw6Sjd86J71wAnWEOLQjIIQ1hugv6hUTH
         A6vfQFIbG/Qf0QDysyt9s9uFku4WCBXc5gghZ0NdFjmKyuMfKhAAK1LvRyFo63fV9H
         8CE3A9RPz45iOuBmEJ8o0lK6flj9ZwI/qilojN7E=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12CB7BKD116117
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 12 Mar 2021 05:07:11 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 12
 Mar 2021 05:07:10 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 12 Mar 2021 05:07:10 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12CB7Apw023321;
        Fri, 12 Mar 2021 05:07:10 -0600
Date:   Fri, 12 Mar 2021 16:37:09 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Michael Walle <michael@walle.cc>
CC:     <Tudor.Ambarus@microchip.com>, <nm@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>, <broonie@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        <lokeshvutla@ti.com>
Subject: Re: [RFC PATCH 0/6] spi: Add OSPI PHY calibration support for
 spi-cadence-quadspi
Message-ID: <20210312110707.lrabch4ketqyyepn@ti.com>
References: <20210311191216.7363-1-p.yadav@ti.com>
 <9c551f56-4c00-b41a-f051-8b7e197fbcdc@microchip.com>
 <20210312101036.jfz2733ssv4nhfey@ti.com>
 <676386736df5e5b22e34b0b5af91c894@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <676386736df5e5b22e34b0b5af91c894@walle.cc>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 12/03/21 11:20AM, Michael Walle wrote:
> Am 2021-03-12 11:10, schrieb Pratyush Yadav:
> > There is usually a delay from when the flash drives the data line (IOW,
> > puts a data bit on it) and when the signal reaches the controller. This
> > delay can vary by the flash, board, silicon characteristics,
> > temperature, etc.
> 
> Temperature might change over time, but the calibration is only done
> once. I don't know how much influence the temperature actually has, but
> our boards are usually operating from -40°C to +85°C. So there might be
> a possible temperature difference of 125K between actual calibration and
> when the flash is accessed.

The algorithm supports a temperature range of -45 C to +130 C. The 
temperature is checked at calibration time and adjustments are made to 
make sure the reads work over the entire temperature range [0].

[0] The current implementation does not have a way to query the 
temperature from the sensor (see cqspi_get_temp()), so it always assumes 
the temperature at calibration time is 45 C. But that can be added later 
once the temperature sensor driver is implemented.

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.

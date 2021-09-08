Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F36403D89
	for <lists+linux-spi@lfdr.de>; Wed,  8 Sep 2021 18:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348198AbhIHQXq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Sep 2021 12:23:46 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42458 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245273AbhIHQXq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 Sep 2021 12:23:46 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 188GMYk0121340;
        Wed, 8 Sep 2021 11:22:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1631118154;
        bh=hLdbEdAIpee+Pfvmua3CrBHECg5KZ3Z9V1I2kAje+DU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=NIi7ROZfcmOTYoRkgWhoQAuxJvX1VYmzUr6Zv2mT4OAo8Gs1NjrtqcPLfoyW3i9yC
         5f2GCfyZFJXGwvCpVExuNCjydosC3UfcGjERxq5Jnve4D6Hb626FlhEw3V9iuArepw
         Uiq6yH9PVTiCuUs5Cg3gGmP/mm2ob/qiCrX6psic=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 188GMYi0115971
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 8 Sep 2021 11:22:34 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 8
 Sep 2021 11:22:34 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 8 Sep 2021 11:22:34 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 188GMX8r126683;
        Wed, 8 Sep 2021 11:22:33 -0500
Date:   Wed, 8 Sep 2021 21:52:32 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Parshuram Raju Thombare <pthombar@cadence.com>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Milind Parab <mparab@cadence.com>,
        Konrad Kociolek <konrad@cadence.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v3 2/2] spi: cadence: add support for Cadence XSPI
 controller
Message-ID: <20210908162230.grweu2zhp4valamk@ti.com>
References: <1630499755-18751-1-git-send-email-pthombar@cadence.com>
 <1630499858-20456-1-git-send-email-pthombar@cadence.com>
 <20210903185653.7vrfn4qfzvuiaiq2@ti.com>
 <CY4PR07MB275737A008CBB58C4B108D2FC1D49@CY4PR07MB2757.namprd07.prod.outlook.com>
 <20210908112113.smnwmayjb3jit3eg@ti.com>
 <20210908122449.GC4112@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210908122449.GC4112@sirena.org.uk>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 08/09/21 01:24PM, Mark Brown wrote:
> On Wed, Sep 08, 2021 at 04:51:15PM +0530, Pratyush Yadav wrote:
> 
> > But it would reduce performance by a lot, no? I think we should try to 
> > figure out how we can accomodate controllers like this before resorting 
> > to using the slower modes.
> 
> OTOH if it's going to be hard to figure out perhaps merging something
> slower that works while we do so would be good - lets people use their
> systems while things are figured out.

I would prefer to solve this problem rather than leaving it for later, 
but either way is fine.

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.

Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2C9A351151
	for <lists+linux-spi@lfdr.de>; Thu,  1 Apr 2021 10:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbhDAI5a (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Apr 2021 04:57:30 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:56000 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233527AbhDAI5B (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 1 Apr 2021 04:57:01 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1318uqf5052252;
        Thu, 1 Apr 2021 03:56:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1617267412;
        bh=cGcqM28hwUnMq94RUS26mmi8GyO7P5f4FTSW7afpD1Y=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=iZfbQ5Sy9Wu91yo9y6VQYENbnmzoaYqIJePHSPdLbZTUa9ef+bukHc6ty6XBqSKJN
         lft3Xt/UJu+ygFAm4JK9p+8o2r8LtzbxtMb4lhQDybXg005V5N1PMTllVY+ZVtwYKk
         YltyydlpzG4nnepb4MfQ/+8kjiny3Bp27kGaFyuk=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1318uqga011899
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Apr 2021 03:56:52 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 1 Apr
 2021 03:56:52 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 1 Apr 2021 03:56:52 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1318uplB019785;
        Thu, 1 Apr 2021 03:56:52 -0500
Date:   Thu, 1 Apr 2021 14:26:51 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>
CC:     Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 4/4] dt-bindings: spi: Convert cadence-quadspi.txt to
 cadence-quadspi.yaml
Message-ID: <20210401085649.deocs3cbd7kiljrf@ti.com>
References: <20210326130034.15231-1-p.yadav@ti.com>
 <20210326130034.15231-5-p.yadav@ti.com>
 <20210327183628.GA345487@robh.at.kernel.org>
 <20210329182256.q4zhss6lezj3s44a@ti.com>
 <1161dc3b-c889-c5d7-f7c8-baf5b7b79505@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1161dc3b-c889-c5d7-f7c8-baf5b7b79505@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 01/04/21 01:57PM, Vignesh Raghavendra wrote:
> 
> 
> On 3/29/21 11:52 PM, Pratyush Yadav wrote:
> >>> +  cdns,fifo-depth:
> >>> +    description:
> >>> +      Size of the data FIFO in words.
> >>> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> >>> +    enum: [ 128, 256 ]
> >>> +    default: 128
> >>> +
> >>> +  cdns,fifo-width:
> >>> +    $ref: /schemas/types.yaml#/definitions/uint32
> >>> +    description:
> >>> +      Bus width of the data FIFO in bytes.
> >>> +    default: 4
> >> I assume there's some constraints on this?
> > IIUC this is a matter of how the peripheral is implemented and there are 
> > no clear constraints. Different implementations can use different bus 
> > widths for the SRAM bus but I don't see any mention of minimum or 
> > maximum values. FWIW, all users in the kernel use a 4 byte bus.
> > 
> 
> IMO a safe constraint would be to set a range of 1 to 4 (8/16/24/32 bit
> wide) given this represents SRAM bus width. Binding can always be
> updated if there exists an implementation with higher SRAM bus
> width/fifo-width (although that's highly unlikely given there are no
> such examples today).
> 
> But leaving it open ended with range of 0 to UINT_MAX sounds incorrect
> to me.

Ok. Will respin.

> 
> >> With that,
> >>
> >> Reviewed-by: Rob Herring <robh@kernel.org>
> > Thanks.
> > 

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.

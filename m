Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 593E929FCC5
	for <lists+linux-spi@lfdr.de>; Fri, 30 Oct 2020 05:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgJ3Emt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 30 Oct 2020 00:42:49 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37182 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgJ3Ems (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 30 Oct 2020 00:42:48 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09U4ggZg025782;
        Thu, 29 Oct 2020 23:42:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604032962;
        bh=eqoZBq5/ceWt03VWmFJalh7jjQmcg8qkau2eAe0ufVk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=BxK0yPKAYrZcupWSyBGf0GEqzw6Memj08XvC4DhWbhc+am+OhGzwlPulHCJMFRMc2
         ehXcnKEpkl1JnfX+5fnhPaWzG2VcMTCdE3zv+WeiaVY83d7zt2VfcxMzSX9uUMD5Ss
         sLvhSpkJQdvtLkOPNzv6Qu6VGDKoXLud+//mwu0E=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09U4ggWb067529
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 29 Oct 2020 23:42:42 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 29
 Oct 2020 23:42:41 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 29 Oct 2020 23:42:41 -0500
Received: from [10.250.233.179] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09U4gdgN040637;
        Thu, 29 Oct 2020 23:42:40 -0500
Subject: Re: [RFC] Accessing QSPI device under mtd
To:     Dinh Nguyen <dinguyen@kernel.org>, <linux-spi@vger.kernel.org>
CC:     "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        <Tudor.Ambarus@microchip.com>, Mark Brown <broonie@kernel.org>,
        Richard Gong <richard.gong@intel.com>
References: <7918ea88-3ede-743e-4444-587d0f625c2e@kernel.org>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <b881ec8a-694f-8025-1dd0-e1c979e43816@ti.com>
Date:   Fri, 30 Oct 2020 10:12:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <7918ea88-3ede-743e-4444-587d0f625c2e@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On 10/30/20 1:17 AM, Dinh Nguyen wrote:
> Hi,
> 
> With commit "a314f6367787ee mtd: spi-nor: Convert cadence-quadspi to use
> spi-mem framework", I can no longer access the QSPI device under
> /dev/mtd<n> on the Intel Stratix10 and Agilex platforms and is breaking
> a few tests we have in-house.
> 
> Can someone point me to how to access the QSPI device using the spi-mem
> framework?
> 

There is should be no visible change to userspace. /dev/mtdX devices
should still get created based on cmdline or ofpart.

Could you elaborate what fails? Is the flash detected and /dev/mtdX
devices created? Is the issue with read or write or erase?

Also what is the kernel version and .config being used? Full bootlog +
testcase that fails would be helpful.

Regards
Vignesh

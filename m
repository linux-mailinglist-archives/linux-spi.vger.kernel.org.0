Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC5833C84D1
	for <lists+linux-spi@lfdr.de>; Wed, 14 Jul 2021 14:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239337AbhGNM5Z (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 14 Jul 2021 08:57:25 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:50338 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbhGNM5Y (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 14 Jul 2021 08:57:24 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 16ECsWIH026905;
        Wed, 14 Jul 2021 07:54:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1626267272;
        bh=O/QNfq0247YcbydOtPhQWfv/gMZs9oNrQKgxHKglwM8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=hpjr4c+BL/mctk0j3xLrLtC+GDPPo8v21vri5XN0afu1V3YGD7hZ3u74KBvDcZnTs
         EGuDioZdRRl0JcUXBgPqfl3dJ9bjr0/8Jke6L37YP/tLjZN7seNT+FelmO2J4hviBz
         229v5fv0+JEisv750XhjnxWfnIaa+D4eLjtePVDw=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 16ECsWtt083889
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 14 Jul 2021 07:54:32 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 14
 Jul 2021 07:54:31 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 14 Jul 2021 07:54:31 -0500
Received: from [10.250.150.52] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 16ECsS7w119953;
        Wed, 14 Jul 2021 07:54:29 -0500
Subject: Re: [EXTERNAL] Re: [PATCH 2/2] spi: cadence-quadspi: Fix check
 condition for DTR ops
To:     Mark Brown <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Pratyush Yadav <p.yadav@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
References: <20210713125743.1540-1-a-nandan@ti.com>
 <20210713125743.1540-3-a-nandan@ti.com> <20210713183903.GH4098@sirena.org.uk>
From:   "Nandan, Apurva" <a-nandan@ti.com>
Message-ID: <bea11e83-2c26-57b5-1a42-8ce852dc26ba@ti.com>
Date:   Wed, 14 Jul 2021 18:24:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210713183903.GH4098@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 14-Jul-21 12:09 AM, Mark Brown wrote:
> On Tue, Jul 13, 2021 at 12:57:42PM +0000, Apurva Nandan wrote:
> 
>> +	f_pdata->dtr = op->cmd.dtr &&
>> +		       (op->addr.dtr || !op->addr.nbytes) &&
>> +		       (op->data.dtr || !op->data.nbytes);
> 
> I'm not sure anyone reading this code is going to figure out what it's
> doing without thinking about it, the combination of writing the bytes
> check with a !, putting it after the check for .dtr and not having any
> comments is a bit obscure.  Something like
> 
> 	(op->addr.nbytes && op.addr.dtr)
> 
> might be a bit clearer, or a comment explicitly spelling it out.
> 

Okay, I will add a comment explaining it, as other logic (with &&) won't
deliver the behavior we expect.

The logic it implements is: for an op to be dtr, if any phase has
non-zero bytes, it must have dtr field set as true. So, it does p
implies q: p->q = (!p || q) i.e. if phase has non-zero bytes (p) then
check its dtr field (q). If all phases are empty, then follow what
op.cmd.dtr says.

Regards,
Apurva Nandan

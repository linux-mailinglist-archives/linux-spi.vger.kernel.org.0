Return-Path: <linux-spi+bounces-9989-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F759B530B7
	for <lists+linux-spi@lfdr.de>; Thu, 11 Sep 2025 13:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9022566DF3
	for <lists+linux-spi@lfdr.de>; Thu, 11 Sep 2025 11:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546EB322C8B;
	Thu, 11 Sep 2025 11:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uomWh5Ea"
X-Original-To: linux-spi@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EBE31C570;
	Thu, 11 Sep 2025 11:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757590455; cv=none; b=tSRmGFVvNEN7Tk38JCX7xVd9KUBVeIMHPua6IypaPlPrlKdkGnO4+7tNLJurOq6Zc0B8FoW/QshK6/RIndIQ/4k/scxRWJEryON9JqzsMSWbEOpQDU1M/OLrwzI5x0WOLRMNW7+mG0jbcf2TlVHzt2cLo9an7rCDJdaEPV5kZ7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757590455; c=relaxed/simple;
	bh=MHJLPizJj9PwysVjP4VNkA1jy0qZ/m9eDWZZUdLDbsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sig8yhCmvfWorPAA7SkMVY4nG3ArYnyVcex9redgOpTK+XwQDh7cWGZrPMIvulO/BLWMt67hCfggQXHPjMirwKI3MIzed6NjNjJBayerkcNGY37hmy4DaK7PZv01dBTzFNFRjysEVTnbvSBJPhKzyju7cRygzoL1UGzib7WZGnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=uomWh5Ea; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58BBY1U0282125;
	Thu, 11 Sep 2025 06:34:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757590441;
	bh=EQRCmjrn5BEyVgJX+y9agEEtvuWsRKQbKKezx698Zxc=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=uomWh5EaNA5DtRZkGL6eyKX9UW8m5bwaTflYTsw4b8pp2lQzlN1sMRuZ8qpJFhbFH
	 zQk1HGT22/m8PsAScbMgywnxNCqQd9vILYdFsZfICQ65K8vocNAmt4ynwP/T0SP3R4
	 XCWLATg7f7uFu1RcWdoBESsddaGIpcz1mTX/u25o=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58BBY1Ck1907627
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 11 Sep 2025 06:34:01 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 11
 Sep 2025 06:34:00 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 11 Sep 2025 06:34:00 -0500
Received: from [172.24.233.254] (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58BBXu8B1763650;
	Thu, 11 Sep 2025 06:33:57 -0500
Message-ID: <bac6b719-8b40-4cdc-a72f-bd612c2d8510@ti.com>
Date: Thu, 11 Sep 2025 17:03:55 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Miscellaneous fixes and clean-ups
To: Mark Brown <broonie@kernel.org>
CC: <miquel.raynal@bootlin.com>, <vigneshr@ti.com>, <marex@denx.de>,
        <computersforpeace@gmail.com>, <theo.lebrun@bootlin.com>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <praneeth@ti.com>, <p-mantena@ti.com>, <a-dutta@ti.com>,
        <u-kumar1@ti.com>, <s-k6@ti.com>
References: <20250905185958.3575037-1-s-k6@ti.com>
 <96bc8718-8902-4f2e-be96-1cd5e19a6355@ti.com>
 <d52cb067-c89e-4f61-8305-031315585e55@sirena.org.uk>
Content-Language: en-US
From: Santhosh Kumar K <s-k6@ti.com>
In-Reply-To: <d52cb067-c89e-4f61-8305-031315585e55@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hello Mark,

On 11/09/25 16:46, Mark Brown wrote:
> On Thu, Sep 11, 2025 at 11:57:05AM +0530, Santhosh Kumar K wrote:
> 
>> Gentle ping on this!
> 
> Please don't send content free pings and please allow a reasonable time
> for review.  People get busy, go on holiday, attend conferences and so
> on so unless there is some reason for urgency (like critical bug fixes)
> please allow at least a couple of weeks for review.  If there have been
> review comments then people may be waiting for those to be addressed.
> 
> Sending content free pings adds to the mail volume (if they are seen at
> all) which is often the problem and since they can't be reviewed
> directly if something has gone wrong you'll have to resend the patches
> anyway, so sending again is generally a better approach though there are
> some other maintainers who like them - if in doubt look at how patches
> for the subsystem are normally handled.

I understand the concern, and apologies for the follow-up.

The first three patches already carry reviewed-by, and the fourth is 
only a macro changes with no functional impact. Given that the merge 
window is approaching, I thought it would be reasonable to send a gentle 
reminder.

Regards,
Santhosh.



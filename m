Return-Path: <linux-spi+bounces-7976-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE6BAADBC4
	for <lists+linux-spi@lfdr.de>; Wed,  7 May 2025 11:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCE837B34B5
	for <lists+linux-spi@lfdr.de>; Wed,  7 May 2025 09:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686151F91C5;
	Wed,  7 May 2025 09:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6M49gvs"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D361F4CB0;
	Wed,  7 May 2025 09:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746611009; cv=none; b=k24zmB4SZRqdZU9GOJ54oRl7VJXoxLYDVqPppDO7IfKNOrRLHUNuyp3qQ0p3AEMlkvMlLIL6AnSYMzomBNjWrcnomX2Eg2jL3KW3oDTxn+1fomQdoG7hif91PQaqbi3TBpvBnlCf193K5iO/vukaPb09BTmBVTw75sFIj5RLeGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746611009; c=relaxed/simple;
	bh=cKqQhS2D19JGhYS3+mIKpASOerLVt7H+njZLr92IpxE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Hjw2Ua463BiyMH4o0zGciNmROQhDJ5GuPqUx6YWe2G7cHnC+OJJc62ml6yFE7HtplRwWSOSR21R4lhN1rkdyFLVE98hGV1qcuATDnT03gMXhF/zjScFTISELRBkw6+wlK7H0Yj7IThgkS15wXX1LjwacU8YHbmOu6dVxdYGbsgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6M49gvs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 907A3C4CEE7;
	Wed,  7 May 2025 09:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746611008;
	bh=cKqQhS2D19JGhYS3+mIKpASOerLVt7H+njZLr92IpxE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=n6M49gvsoUJ7UWEi5D9zdmmXvaTPb6G63b/qCGLDz2fhh+WBuoWHZA89OoUByMK9t
	 nbMRV1AVtoCYzUX3RLVrozZ2WSGGdPjk8Bwohx82LzStIX6FWjej2HR/8ul2doND/D
	 7GWjpJ+vKJ/1cQq6H82y5NS6Zi2LH7w2pk4Bos5ipVcY8rRkNcCMBb6ijPfjTf1Mxu
	 sn+tX54AAmnwq+lf9Z9YZbx24ORUKgdAiyIS8FBsFeBhMjzVQvPSE6/WohgfAgnIcx
	 cYwVSRgex6Mqs86C96u8cIVWdplAvsf9TijdbQOT0AaPPq188q881f+r7cnVtPFqUl
	 SNZX9X/lBqT7w==
From: Pratyush Yadav <pratyush@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Luke Wang <ziniu.wang_1@nxp.com>,  "pratyush@kernel.org"
 <pratyush@kernel.org>,  "broonie@kernel.org" <broonie@kernel.org>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
  "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
  "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
  "michael@walle.cc" <michael@walle.cc>,  "miquel.raynal@bootlin.com"
 <miquel.raynal@bootlin.com>,  "p.yadav@ti.com" <p.yadav@ti.com>,
  "richard@nod.at" <richard@nod.at>,  "vigneshr@ti.com" <vigneshr@ti.com>,
  Bough Chen <haibo.chen@nxp.com>,  Han Xu <han.xu@nxp.com>
Subject: Re: [PATCH v2 6/6] mtd: spi-nor: core: avoid odd length/address
 writes in 8D-8D-8D mode
In-Reply-To: <10b40148-b949-442d-9d43-0db09517269a@linaro.org>
References: <DU2PR04MB85678048FE8B475B1E323E0AED802@DU2PR04MB8567.eurprd04.prod.outlook.com>
	<10b40148-b949-442d-9d43-0db09517269a@linaro.org>
Date: Wed, 07 May 2025 09:43:25 +0000
Message-ID: <mafs0zffo3gea.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Luke,

On Tue, Apr 29 2025, Tudor Ambarus wrote:

> On 4/29/25 10:03 AM, Luke Wang wrote:
>> Hi Pratyush,
>> 
>> I'm following up on this patch series [1] Avoid odd length/address read/
>> writes in 8D-8D-8D mode. While some of the series has been merged, the
>> patch 4-6 remains unmerged.
>> 
>> In fact, we also encountered similar read/write issue of odd address/
>> length with NXP FSPI controller (spi-nxp-fspi.c). Currently, we handled
>> the odd address/length in the controller driver, but I think this should
>> be a common issue in the octal dtr mode. Was there a technical reason
>> for not merging the core layer solution?
>
> I guess I stumbled on those small comments and did not consider the
> greater benefit of taking the patches. No one cared and we forgot about
> it. Please address the comments and resubmit.

Yes, it should have been a simple next revision from me but apparently
it fell through the cracks. I do strongly agree that this should be done
in SPI NOR, and not in controller drivers. So it would be great if you
can respin the remaining patches of the series.

-- 
Regards,
Pratyush Yadav


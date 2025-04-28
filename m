Return-Path: <linux-spi+bounces-7779-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46763A9EB0E
	for <lists+linux-spi@lfdr.de>; Mon, 28 Apr 2025 10:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6619B3AE930
	for <lists+linux-spi@lfdr.de>; Mon, 28 Apr 2025 08:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3978D1DF244;
	Mon, 28 Apr 2025 08:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="K35f0nYN"
X-Original-To: linux-spi@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB2AD530;
	Mon, 28 Apr 2025 08:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745829883; cv=none; b=UAoxJeF2NzcfDnDp19VpU98P0V5iQg8oLOAwUFROZLJyESHjypScQ5xI+LmRkDhQ6hSnmCdS9OL/ScmvMyD6PdRLaYFa8aLqzrUNWn1nnC0xmXHtyVbk8PFrawDVpV9xWWvKOBN0bacR24F/UQmt9X3cDiOTqQd2lDl22KzWaY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745829883; c=relaxed/simple;
	bh=kDOOlpn4hGdk871V+vnkWTEeaPJnfV7z1o0lIRv9PQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jYoaPE0VkO0gYAJvm6dGVtauaxS80t+lE1jzGkN1X0GP1pqc0IH4ns9Dq3PddqomvaO5acEFOuX8FU7mKZNVQx4JjXcabam5ozfFAjjWwU4NO0kwaQ+iXTXGO+BYJGJelAlttn+qBcLMsUsDhHWWfViK6pR59VWRDXuNljtw4yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=K35f0nYN; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 16E47A06AB;
	Mon, 28 Apr 2025 10:44:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=wxyYoBi3DgL4L83PBPGH
	n8OH+IryRzFYeqAsCylOSvo=; b=K35f0nYNDFT1Y4R6KNbrf7God9fUefsg/NU/
	lJAzVssoQE/gfdvfu1j1qWPHA/j0EbtInFVCmZeoVKlILUPNKNgcM3+u9T65Bsm3
	gbNCUrifGBZCgAX/oRnX/k3IR98iMcTVFGn2I4jgSv3fEg3/HmYlvRIO3sq885sL
	foz9rpvtJEXMLLV69BbWDPCZzLAFCeof2LcZxe46u0Al1bfjUTDgYIRKEd3/aE/E
	JN0XBZR2tEmu1ezpE5OhHJn80Fzzoo5OpkkCpBSY6FbmhFGcuvXTdILDIyc1/+IP
	tnuZ8l88auW8+Q8zoj7YC2yiiG8CpTbINO54XmUJICqxrc0AtU76Q22xen+bC6PC
	8aRRVwOIglvUpKR8WZkziLLKJdHP7XMy9xJZL+feht5+Z9HNvQcKRcvXuppKSJFs
	nt70fA9RSNOJqb24hmU9dTwSNC372qzFBweuHxfskG0O+QVE1K0yynAlvN1mxPTi
	X7pgxVB4vZ5gjOOzEJYZbDnKTBz3X+iBRcXqUQPycgSbYtqpeSnHmhn1j9FzcM9o
	tZ81VCViEavhaSmg7NDqdGBEhPaoDxbWKM5IGclh3dcRK3NXag9pIE2Z17KdcNv8
	27/jK0l1/89VnRjw66Fevo6LrcNzIhyvy9hId+bPMYwIAiq2Zgaxrl3tIyWYTe37
	44mHwgc=
Message-ID: <b38b27d4-c3d3-450c-8634-2e07f393a76c@prolan.hu>
Date: Mon, 28 Apr 2025 10:44:28 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] pm: runtime: Add new devm functions
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Varshini
 Rajendran" <varshini.rajendran@microchip.com>, Tudor Ambarus
	<tudor.ambarus@linaro.org>, Mark Brown <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>, "Len
 Brown" <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, "Alexander
 Dahl" <ada@thorsis.com>, Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>, Pavel Machek <pavel@kernel.org>
References: <20250327195928.680771-2-csokas.bence@prolan.hu>
 <20250327195928.680771-3-csokas.bence@prolan.hu>
 <CAJZ5v0jmuzvo-xzGBDhGVBbY7svbrqEdi-SeJrx5BG=qtN6ZiQ@mail.gmail.com>
Content-Language: en-US, hu-HU
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <CAJZ5v0jmuzvo-xzGBDhGVBbY7svbrqEdi-SeJrx5BG=qtN6ZiQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94853677366

Hi,

On 2025. 04. 09. 19:43, Rafael J. Wysocki wrote:
> On Thu, Mar 27, 2025 at 8:59 PM Bence Csókás <csokas.bence@prolan.hu> wrote:
>>
>> Add `devm_pm_runtime_set_active_enabled()` and
>> `devm_pm_runtime_get_noresume()` for simplifying common cases in drivers.
>>
>> Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
> 
> I can apply this one alone if you want me to do that, but I could also
> apply the other patch in the series if it got an ACK from the driver
> maintainer.

Did this end up being applied?

Bence



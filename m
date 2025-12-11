Return-Path: <linux-spi+bounces-11866-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E26A7CB629F
	for <lists+linux-spi@lfdr.de>; Thu, 11 Dec 2025 15:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5C4863001BD2
	for <lists+linux-spi@lfdr.de>; Thu, 11 Dec 2025 14:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A726C226CF1;
	Thu, 11 Dec 2025 14:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="F51875p7"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7332236EE
	for <linux-spi@vger.kernel.org>; Thu, 11 Dec 2025 14:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765462619; cv=none; b=Ioj8a5l6JFNf2df94L8JwvRDmSbzUB7tT56sCHDGwwV0f+9Yvmx/sqjUJ8bnEWBkd4JG68hcipHveJZg3Zc5D9lzeYMwi0XypcQxHj2GzXph2xQOSqgaW/tExNFGbxoXEJwFSehxG7hE5rYM+/63vdC3ns36FhkGC0u5txIDh1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765462619; c=relaxed/simple;
	bh=l82uC19Iu/GcmFWQIWIS6+UXXzmtlcb0dUcv3MCyk38=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b7QQGJs0Y1KzNGxFJV0Rp5rnw4YxEFpCJC18cvSe1nHNVa7KXkNMcPy1RNZIBoml8m3AOeXrd0oSCazvl3zDKLc7kgp39AbHNz0za10I9vMQvtR/5ox0kv+Bib5jvPvUZQJKVDcAPa1fXidYqeOzZj35y6ElA/NYtWFpoaq3t0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=F51875p7; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 639521A20EC;
	Thu, 11 Dec 2025 14:16:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 372A96068C;
	Thu, 11 Dec 2025 14:16:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CE08B103C8C1E;
	Thu, 11 Dec 2025 15:16:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1765462608; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=LN2XRvJPP64/tzjn2G4k9S/sITzG6yY/jxfa/OMZy/U=;
	b=F51875p7OT407UAmMFyy2xslQJqdFc+r9NgYdqDorB7cQTU04s3jIFN9UJfITEWvBsMnPh
	+GLocod0FOo8RsEhHvNqDTPmjzaoHObupoq9n2A51iDxzTNE25C3J5uoRL7L1S82E5AU6c
	ralrEIHHjvwTAcB8azruXAbWhvJPtqDKWdpTFLdv7NjwUyS7GkIHsUnlDRpjhxr5Vhq3sc
	ljcDVrkAe99eLf09xwSyH4WdbSrpVBaTZXTsiTGHarNFc0UkuK3bzmYhcvyNV8/SZaX70q
	5DWMkd+ODnfJd7ya8M/McQqyKSXeXspRGdklx56MELSDcFHIj0yiJknktOhEvQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: Michael Walle <mwalle@kernel.org>,  Pratyush Yadav
 <pratyush@kernel.org>,  <richard@nod.at>,  <vigneshr@ti.com>,
  <broonie@kernel.org>,  <tudor.ambarus@linaro.org>,  <p-mantena@ti.com>,
  <linux-spi@vger.kernel.org>,  <linux-mtd@lists.infradead.org>,
  <linux-kernel@vger.kernel.org>,  <a-dutta@ti.com>,  <u-kumar1@ti.com>,
  <praneeth@ti.com>
Subject: Re: [RFC PATCH 01/10] spi: spi-mem: Introduce support for tuning
 controller
In-Reply-To: <ea6f3dd7-0732-4de9-8bf1-e88a45ad6ac2@ti.com> (Santhosh Kumar
	K.'s message of "Wed, 10 Dec 2025 17:04:09 +0530")
References: <20250811193219.731851-1-s-k6@ti.com>
	<20250811193219.731851-2-s-k6@ti.com> <87seguemzu.fsf@bootlin.com>
	<cb04a4ec-c643-4b80-9288-8fd8944cb4f7@ti.com>
	<mafs0ikf74fja.fsf@kernel.org>
	<fe103265-7a68-41b8-b168-15a5e19abb3f@ti.com>
	<DEOH4AUI33SQ.DGKJ4W258658@kernel.org> <87jyz3ao8b.fsf@bootlin.com>
	<ea6f3dd7-0732-4de9-8bf1-e88a45ad6ac2@ti.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Thu, 11 Dec 2025 15:16:43 +0100
Message-ID: <878qf96r3o.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3


>>>> 2. Using of_get_* APIs:
>>>>         Using the standard OF helpers to locate the phypattern partiti=
on
>>>>         and retrieve its offset is both reliable and straighforward, a=
nd
>>>>         is the approach currently implemented in v2.
>>>
>>> I don't like that hardcoded partition name which is basically
>>> becoming an ABI then.
>>>
>>> At least we'd need some kind of phandle to the partition inside the
>>> controller node (and get the ACK from the DT maintainers).
>> Yes, agreed, this is controller specific, if we need to use an of_ API
>> (which is still not needed for SPI NANDs, only for tuning the read SPI
>> NOR path), it should not just be a partition hardcoded name but a
>> phandle in the controller node.
>
> Yes, using a phandle is a valid idea to avoid relying on a hard-coded
> name. But, it does not work well when multiple chip selects are
> involved. The controller is not tied to a single flash device - a single
> SPI controller may host both NOR and NAND flashes, for example. In such
> case, only the NOR would require this phandle, while the NAND would
> not,

This honestly doesn't seem a problem to me.

> which makes the phandle approach unsuitable. Another example is a
> controller hosting two NOR flashes - both would then need their own
> phandle references.
>
> An alternative would be to associate the phandle with the flash device
> itself rather than with the controller. Let me know your thoughts on
> this approach.

I find pretty strange to have this property in the flash node, even
though I understand the reason. Perhaps an array of phandles may work in
the controller node instead?

Thanks,
Miqu=C3=A8l


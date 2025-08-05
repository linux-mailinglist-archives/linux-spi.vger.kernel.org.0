Return-Path: <linux-spi+bounces-9285-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4238EB1AF89
	for <lists+linux-spi@lfdr.de>; Tue,  5 Aug 2025 09:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B45B189D4DA
	for <lists+linux-spi@lfdr.de>; Tue,  5 Aug 2025 07:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E2A2192F5;
	Tue,  5 Aug 2025 07:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="L4C3MbFc"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A49618C011
	for <linux-spi@vger.kernel.org>; Tue,  5 Aug 2025 07:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754379791; cv=none; b=scLkCPrpD8QbjarcOAoiJLHuNAioCLrsAvg6VPopv8hqQP772iumzl4Ux6Hba5cBQZCZQrP1lMgpgwHZsCCT56uj8xbIk5GRnfdm/jAEvR5oejUoN6zwNd0Isniyj+lfUoo6otjaxp45zVLcvd9OKNs/PWU00kQ37skeJWc1sns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754379791; c=relaxed/simple;
	bh=hYG/JYnu6MPsqQC+bkZ11PSQEyXrliWw42E/F9XK8rI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ApdUrgZUTLydbtlN40E4ffEWK9VDiPvgImwqIx6WI14gdcSf465Hd9zdsTQag4OvMH6mX2/FtI/Y5PeYyKym7o2AdhyAq43kNky5LSmCW2gr4+er06X4bYM7JxpLTGJE8BtKb1T/nrcWOkbExv4LKy+VO/HhgtbIbEARItabuME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=L4C3MbFc; arc=none smtp.client-ip=217.70.178.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 67B9E43194;
	Tue,  5 Aug 2025 07:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1754379781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hgivh3BaaqDG4fczjDXXKEN33iKWFj7f9BUj4tGZTrk=;
	b=L4C3MbFcm+IPMdxln2d64iaOMLDruOCi8lHxnJ+Vg6n6ycqGa41DfY6Q2568RpyNpPdXwu
	g1ai3Kw2f5pv4++cXUvxabTVRE8iMBLRDRgXCCzu4+KjEkRbHSgscDR4jBj5EUlyXxVJkH
	zevkYIln4iqJfQz+wlqezZ+jtm+3PC2CAFVacmxgPLsXGwWbbSys6lJx2FuS2mFpSee0Oh
	4pUpP+TXUVjH+pA+ZVn714qQDJw7aZ4puH0l7u0WeO2w+1AjlraUnC/sJVMW/H+T329MOC
	oomSffWpRAAjwvcL8kBKIBQe+qaXf3xL6MdpisECsE2f3ac9KACujOZBoyk/VA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Mark Brown <broonie@kernel.org>,  <linux-spi@vger.kernel.org>,  Richard
 Weinberger <richard@nod.at>,  Vignesh Raghavendra <vigneshr@ti.com>,
  Tudor Ambarus <tudor.ambarus@linaro.org>,  Michael Walle
 <michael@walle.cc>,  <linux-mtd@lists.infradead.org>,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] spi: spi-mem: Add missing kdoc argument
In-Reply-To: <mafs0ms8fcfhg.fsf@kernel.org> (Pratyush Yadav's message of "Mon,
	04 Aug 2025 16:45:47 +0200")
References: <20250804095013.409700-1-miquel.raynal@bootlin.com>
	<mafs0ms8fcfhg.fsf@kernel.org>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Tue, 05 Aug 2025 09:43:00 +0200
Message-ID: <87tt2mi58b.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudegiedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgefhjedtfeeigeduudekudejkedtiefhleelueeiueevheekvdeludehiedvfeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedutddprhgtphhtthhopehprhgrthihuhhshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqshhpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrihgthhgrrhgusehnohgurdgrthdprhgtphhtthhopehvihhgnhgvshhhrhesthhirdgtohhmpdhrtghpthhtohepthhuughorhdrrghmsggrr
 hhusheslhhinhgrrhhordhorhhgpdhrtghpthhtohepmhhitghhrggvlhesfigrlhhlvgdrtggtpdhrtghpthhtoheplhhinhhugidqmhhtugeslhhishhtshdrihhnfhhrrgguvggrugdrohhrgh

On 04/08/2025 at 16:45:47 +02, Pratyush Yadav <pratyush@kernel.org> wrote:

> On Mon, Aug 04 2025, Miquel Raynal wrote:
>
>> The "*mem" pointer has been added without description, describe it in
>> the kdoc comment in order to fix the following W=3D1 warning:
>
> Hmm, this warning does not show up for me with W=3D1, but does with W=3D2=
. I
> am running:
>
>    make drivers/spi/spi-mem.o LLVM=3D1 ARCH=3Darm W=3D1

It shows up on my side with W=3D1, but not with LLVM. No idea if makes a
difference?

Cheers,
Miqu=C3=A8l


Return-Path: <linux-spi+bounces-6051-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BFB9F0BE1
	for <lists+linux-spi@lfdr.de>; Fri, 13 Dec 2024 13:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD6B8188A79B
	for <lists+linux-spi@lfdr.de>; Fri, 13 Dec 2024 12:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403121DF26A;
	Fri, 13 Dec 2024 12:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="otai4DWa"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1081DF263
	for <linux-spi@vger.kernel.org>; Fri, 13 Dec 2024 12:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734091562; cv=none; b=V0dcIZrf9Bwcws5p1WIeAyfFIilvGSZPw89F+79k1KAi6+W4PbZT/zERSdtKkvoVLeVGV9RAArDdkjiyQ8v8G3d8XnYT5hAhBkD5JULEA26zMa9eE3qcG6IaLD8ebiQamlb9UoDYJj9NgLVstv64D41cOs9wvnuK2ptgNGd6/Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734091562; c=relaxed/simple;
	bh=avy/BlXoQkszE0jt+F0OzGXyNcKlIcugyvwNkYd3bwc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u+oyRY9DDcoONOME8kVoWOhxd0fh77TckV3WBliU3HXmYiZAdwi+gMszpOf1/uMTllq6WQN+5Xv4ueyJxTShRSdgWOskd9R0rruzBbtiwLOrAn25SvqpVIhwKiSl50iw72wbJbG+fHQNSC7+ZC/VBDkXUOsmAfKI+5RjtS7qDmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=otai4DWa; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 761CAC0002;
	Fri, 13 Dec 2024 12:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734091557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q07hAkDq3YBTICoUg/PyYGARG9zUOS05b+cgj9MMFrA=;
	b=otai4DWajRI4i/NYyp88WU/zXYTboiWvXXNaQIogvMyWjQYCGTURwGlxUFjkRSKqpe4poH
	YEWihwdelPzf4RpF4JbbMuqPTacQDQqVRT2EgXLXm6blKvbY4A2C9FmppM1IALhu3DcX2J
	1TSigIT5RnmZz0oAvQ+rLpgrgrXsiCQzh5/WGVwFQe+xE1/i+aIqp2cTs5mI4gx7t0/8aJ
	CDN1Hy8Wq01UScsFOJVbzO73dfFtPGsYgXPWWfqA+3TsDjLuDXKzPU0ZSZmJKij9KQep9b
	mXQvbwOqvmLjClMEyOSz2J4Xtey+HBLdlvOJj6EMcCKF3dBWIXvddPr0BYDVkQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Pratyush Yadav <pratyush@kernel.org>,  Michael Walle
 <michael@walle.cc>,  linux-mtd@lists.infradead.org,  Mark Brown
 <broonie@kernel.org>,  linux-spi@vger.kernel.org,  Steam Lin
 <stlin2@winbond.com>,  Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
  Sanjay R Mehta <sanju.mehta@amd.com>,  Han Xu <han.xu@nxp.com>,  Conor
 Dooley <conor.dooley@microchip.com>,  Daire McNamara
 <daire.mcnamara@microchip.com>,  Matthias Brugger
 <matthias.bgg@gmail.com>,  AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>,  Haibo Chen
 <haibo.chen@nxp.com>,  Yogesh Gaur <yogeshgaur.83@gmail.com>,  Heiko
 Stuebner <heiko@sntech.de>,  Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH 20/24] spi: spi-mem: Reorder SPI_MEM_OP_CMD internals
In-Reply-To: <7871b283-7623-4a21-ab75-42359a7c29ae@linaro.org> (Tudor
	Ambarus's message of "Mon, 11 Nov 2024 14:32:27 +0000")
References: <20241025161501.485684-1-miquel.raynal@bootlin.com>
	<20241025161501.485684-21-miquel.raynal@bootlin.com>
	<7871b283-7623-4a21-ab75-42359a7c29ae@linaro.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 13 Dec 2024 13:05:55 +0100
Message-ID: <87y10jlrdo.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: miquel.raynal@bootlin.com

>>  #define SPI_MEM_OP_CMD(__opcode, __buswidth)			\
>>  	{							\
>> -		.buswidth = __buswidth,				\
>> -		.opcode = __opcode,				\
>>  		.nbytes = 1,					\
>> +		.opcode = __opcode,				\
>> +		.buswidth = __buswidth,				\
>>  	}
>>  
>
> I don't mind, but shouldn't we follow the order used at struct declaration?
>
> struct spi_mem_op {
> 	struct {
> 		u8 nbytes;
> 		u8 buswidth;
> 		u8 dtr : 1;
> 		u8 __pad : 7;
> 		u16 opcode;
> 	} cmd;

Sure, let's do that. I also corrected the other macros at the same time (v2).


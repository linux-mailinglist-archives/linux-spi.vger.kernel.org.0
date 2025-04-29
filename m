Return-Path: <linux-spi+bounces-7796-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 261EEAA0729
	for <lists+linux-spi@lfdr.de>; Tue, 29 Apr 2025 11:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 024FF843B5E
	for <lists+linux-spi@lfdr.de>; Tue, 29 Apr 2025 09:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD062BD59C;
	Tue, 29 Apr 2025 09:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VGhUfXtx"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD0029DB7B;
	Tue, 29 Apr 2025 09:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745918836; cv=none; b=TyqkvLCG1Jb+kV4gEn0Idjz9qHRW9Eho0sNlIQ2NqONT0Dm/wr8+37FuwV7UupO4QELDo9pyX483jqwC0H8NqwClSntCuQl3tptAMmN2tRV/MKt0SzwUPBVWhWFYwDA7KsHCGSZa6mN9s2jCD95OCAelG63n4DD2h+bsynhmZ5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745918836; c=relaxed/simple;
	bh=CASvlc42clKz5BfrQgoRV2/Mwzi6UHy9iT9YN0nWlVY=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AemZ0uLzT8GcvPerGThrnedT7N1hT7B+n927m70z0xVpbANq+zS+xTgRDpmQQ4AYziOReVafDiyRkQeWDtY7vu7iQt72KpeV27Gd7Fpi4jlImyRNvlT176wOqUAgdaUJQ2CtN8qkopACKalSudnoZBphQxAdv6FeRP1jWNyjAow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VGhUfXtx; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A2EA24330A;
	Tue, 29 Apr 2025 09:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1745918827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2BEsZEXCs1M05aaWraZX8cJyox+y1wvJ/ugKyQkcHbk=;
	b=VGhUfXtxFKlop6RasrXGGIa4QPusXTmg13rZxFcrkSxVIv6k82G+oj10XdYEL6KgV5GkDM
	FohdJRKPRI0x+H+7xgSMGj4qeH4ZFF4MUHhSct/4EEM0hOGs7WSyVH5cMdpL8xCFhLOvDd
	Q0C5Aquva6Z27TRWbMhWwJLDupysLbtNt32/DDgV1taCGmxZ3Xy2FvWzLX26CKhFins1PT
	FqqL2iHODiHk+lZm2q5Uo8LxtTa6kgZNQuH3XYgCb03/gdnS9cLZ9fnC/Xbu4+Q5a43W7Z
	QBzuDy7CdNgyDmNRpOuFthm4ATyw2kNM+iV5PMTBIBVo4WHH/bL8144dzVQTAg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: richard@nod.at, vigneshr@ti.com, manivannan.sadhasivam@linaro.org, 
 broonie@kernel.org, absahu@codeaurora.org, bbrezillon@kernel.org, 
 architt@codeaurora.org, quic_srichara@quicinc.com, 
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org, 
 Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <20250410100019.2872271-1-quic_mdalam@quicinc.com>
References: <20250410100019.2872271-1-quic_mdalam@quicinc.com>
Subject: Re: [PATCH v4 0/3] QPIC v2 fixes for SDX75
Message-Id: <174591882547.993955.17062615074678307127.b4-ty@bootlin.com>
Date: Tue, 29 Apr 2025 11:27:05 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieefgeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfgjfhfukfffgggtgffosehtkeertdertdejnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepfffhudefgfeuueehueevudeiieejhfejudevudevieetvdetfedtfffhjeeileefnecukfhppeelvddrudekgedruddtkedrvdehheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeelvddrudekgedruddtkedrvdehhedphhgvlhhopegludelvddrudeikedruddruddtiegnpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudefpdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqmhhtugeslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhmshhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrnhhivhgrnhhnrghnrdhsrgguhhgrshhivhgrmheslhhinhgrrhhordhorhhgpdhrt
 ghpthhtoheprggsshgrhhhusegtohguvggruhhrohhrrgdrohhrghdprhgtphhtthhopehquhhitggpmhgurghlrghmsehquhhitghinhgtrdgtohhmpdhrtghpthhtohepqhhuihgtpghsrhhitghhrghrrgesqhhuihgtihhntgdrtghomhdprhgtphhtthhopegrrhgthhhithhtsegtohguvggruhhrohhrrgdrohhrgh
X-GND-Sasl: miquel.raynal@bootlin.com

On Thu, 10 Apr 2025 15:30:16 +0530, Md Sadre Alam wrote:
> The BAM command descriptor provides only 18 bits to specify the NAND
> register offset. Additionally, in the BAM command descriptor, the NAND
> register offset is supposed to be specified as "(NANDc base - BAM base)
> + reg_off". Since, the BAM controller expecting the value in the form of
> "NANDc base - BAM base", so that added a new field 'bam_offset' in the
> NAND properties structure and use it while preparing the command descriptor.
> 
> [...]

Applied to nand/next, thanks!

[1/3] mtd: rawnand: qcom: Pass 18 bit offset from NANDc base to BAM base
      commit: ee000969f28bf579d3772bf7c0ae8aff86586e20
[2/3] mtd: rawnand: qcom: Fix last codeword read in qcom_param_page_type_exec()
      commit: 47bddabbf69da50999ec68be92b58356c687e1d6
[3/3] mtd: rawnand: qcom: Fix read len for onfi param page
      commit: e6031b11544b44966ba020c867fe438bccd3bdfa

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl



Return-Path: <linux-spi+bounces-8572-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3086ADAE6E
	for <lists+linux-spi@lfdr.de>; Mon, 16 Jun 2025 13:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 415A11887FB6
	for <lists+linux-spi@lfdr.de>; Mon, 16 Jun 2025 11:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39BD2C08B4;
	Mon, 16 Jun 2025 11:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="OrcJD8QV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nwBZ4NGb"
X-Original-To: linux-spi@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594542D9EF3;
	Mon, 16 Jun 2025 11:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750073313; cv=none; b=DB1W8e7fXlNHl78bUvWftydRRZdpSwZSbOwWFH5RWVOYby4JX+wkR0fMg22s6hZyzDV+VEZu6ojGxEN77D5S18bIon9Zjl035Pq02TpM7Xl+BDhy/eNL01097cjPY9kPw7oZNHaPUP+9PCfS8QxdWyhpX7JaMB9ElW/mR2ntzXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750073313; c=relaxed/simple;
	bh=kwKwjxom4d2Clj5IKZBF+Gh4TrODLRQoQQE/qE6/bhE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=t6A7fa+2zDHHakFPP7dsPlPxnD3bQsb+mSy9fdfGcvdGRqLVDlg2BN2JNDwGzSC6ekOqfarWWqoq/1hb897gBjAcIwRCmYLBHrUonHPto0QW0rPwTzUodziWw5ogJytrw9nSVGJcVAVktk6rn0mFBI7MJqCKCSqg0fegAlFckuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=OrcJD8QV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nwBZ4NGb; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 0EE161140187;
	Mon, 16 Jun 2025 07:28:30 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Mon, 16 Jun 2025 07:28:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1750073309;
	 x=1750159709; bh=BVMDxZyh3izjfJAnNlsndwBLshhlRT2Ze7VL++djkf8=; b=
	OrcJD8QVYTRhsoyYQ0cyohPkjdpt+ai5PwbIJEkleDS5aZUjTubyu5x9ywbZaGR9
	aW3WxPsEB/8T8Ihm0HCmMSiCzSV8oS6dR5479NzttSZbENg7ko0Acq6F14Yq4A5h
	RuqlndtjQuV9ffrrHduRjVGvlIcSoh+rYpM3EsOtE3wQzZJnY3U1bnDDmnxk0Wpt
	Cc/1/9TI5hGuZi3sdzM7NL8DZ1Du310xMQKo0DsmpbDajYmI8611ikobEDv+Eo1S
	25yQjpr0hTc7k84mYmbtphGM7AxjVvbcBfN+cypI6IYviFVaxguZU+Oj4U/re15m
	GJ8OP/LIpiZOIu2auHZosQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750073309; x=
	1750159709; bh=BVMDxZyh3izjfJAnNlsndwBLshhlRT2Ze7VL++djkf8=; b=n
	wBZ4NGbFS28NdjYFzZe+tNjg5Gs4n7S1GOSAdMglbHy+5bBBnhRzezK6iBEORItP
	6lT1VLK37LQuCnOzfY1Z3rwkDStQo+9R9QG68wawr8A5CMLx2ZlF11NZgQbmw58o
	fsmmXSFxHJEQLIuNNrvvecRk8YJNNaEi4FCiIqFdjm5O/asb7GajXIPPYQO4oHjj
	PklplRKuf2oclQ/w4xRn1f1lApXj9VM6JflNZdSxpsJ9925u+9kHdsSFsVTyHWEv
	e4k0aXZaT2AZOC8vmsX9SzNK0/4/dR8hqhOAJ7IANPkZ6Enm82AmetLiaq214dv+
	4Pnq2+co6P7YOH17FiPmQ==
X-ME-Sender: <xms:3P9PaNUnQVMHUu4XWcFLlylXS0eP-at0_KY5Shza6RruFae920owdA>
    <xme:3P9PaNlv2bKfspANLmvW5eCcAKtKIasAbBCs0cHOljCbnYk5kkEGlGuZpvbHqBZCL
    h0vyvH3TCZyGpPjBL8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvieegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpeefhfehteffuddvgfeigefhjeetvdekteekjeef
    keekleffjeetvedvgefhhfeihfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegr
    rhhnuggsrdguvgdpnhgspghrtghpthhtohepudegpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehrohgsihhnrdhmuhhrphhhhiesrghrmhdrtghomhdprhgtphhtthhopeho
    lhhtvggrnhhvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhkphesihhnthgvlhdrtg
    homhdprhgtphhtthhopegsrhhoohhnihgvsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehjrghmvghsrdgtlhgrrhhksehlihhnrghrohdrohhrghdprhgtphhtthhopehimhigse
    hlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepihhomhhmuheslhhishhtshdr
    lhhinhhugidruggvvhdprhgtphhtthhopehovgdqkhgsuhhilhguqdgrlhhlsehlihhsth
    hsrdhlihhnuhigrdguvghvpdhrtghpthhtohephhgthheslhhsthdruggv
X-ME-Proxy: <xmx:3P9PaJbtfcII8kzrU1FJpVnWlx4UYkFWT6n_eR-B2zWTyTjgBREBKA>
    <xmx:3P9PaAVZPlJo80npW_EEzKEN4IbN0rxFSiaBjdGQeHxk4iwXhq-iyw>
    <xmx:3P9PaHkpZqsJiaQ6KmJX84qoYqtV_3a_3IeySqfhlO4kTMnG79N_ng>
    <xmx:3P9PaNf6NG5OjRgHxLwOWM8K4SHTMGCej1dOzxxo2U9hXLu9ke3eWw>
    <xmx:3f9PaBo6tmID6JpPEkkm-X_XtyPzIYfFOM3pzMFLRLRNlKVF4hpFcwTW>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8C069700062; Mon, 16 Jun 2025 07:28:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T4808b90e09d8ad4f
Date: Mon, 16 Jun 2025 13:28:05 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "James Clark" <james.clark@linaro.org>, "Christoph Hellwig" <hch@lst.de>
Cc: "Vladimir Oltean" <olteanv@gmail.com>, "Mark Brown" <broonie@kernel.org>,
 oe-kbuild-all@lists.linux.dev, "Larisa Grigore" <larisa.grigore@nxp.com>,
 "Frank Li" <Frank.li@nxp.com>, linux-spi@vger.kernel.org,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org,
 "kernel test robot" <lkp@intel.com>,
 "Marek Szyprowski" <m.szyprowski@samsung.com>,
 "Robin Murphy" <robin.murphy@arm.com>, iommu@lists.linux.dev
Message-Id: <86ad0f01-1c07-4a9d-bb63-3ddf8f88d988@app.fastmail.com>
In-Reply-To: <20250616111749.316413-1-james.clark@linaro.org>
References: <202506160036.t9VDxF6p-lkp@intel.com>
 <20250616111749.316413-1-james.clark@linaro.org>
Subject: Re: [PATCH] dma-mapping: Stub out dma_{alloc,free,map}_pages() API
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Jun 16, 2025, at 13:17, James Clark wrote:
> The implementations are in mapping.c which requires HAS_DMA so stub them
> out if not present. This is required for some drivers to pass randconfig
> builds.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: 
> https://lore.kernel.org/oe-kbuild-all/202506160036.t9VDxF6p-lkp@intel.com/
> Signed-off-by: James Clark <james.clark@linaro.org>

Looks good to me

Acked-by: Arnd Bergmann <arnd@arndb.de>

It may be worth adding here that HAS_DMA is set on almost
all configurations, this only showed up as an error in
a randconfig build for m68k/dragonball, which is barely
supported at all.

The other two architectures without DMA support are sh-nommu
and uml.

     Arnd


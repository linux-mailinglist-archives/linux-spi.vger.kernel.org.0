Return-Path: <linux-spi+bounces-7235-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A27BFA699FF
	for <lists+linux-spi@lfdr.de>; Wed, 19 Mar 2025 21:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6382C3AE352
	for <lists+linux-spi@lfdr.de>; Wed, 19 Mar 2025 20:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C4B20AF89;
	Wed, 19 Mar 2025 20:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZPEBDzrC"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D2B1A072A
	for <linux-spi@vger.kernel.org>; Wed, 19 Mar 2025 20:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742414936; cv=none; b=amy027WFFX8bAuZJVBp5ZGL65Db7SkJt3PUPeTW2dXC40+ELXqPJ3B0SeyZqNp11qSnryiryIh6We/4Qymxoy7O47M/jlc2X1bC8Usyqn7Y7FZqv8YL4bFEzqQc/as7ko5EN8YdKUMIPHEklxnvVzdhZ3+KYcs3qGGA8YVtAGo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742414936; c=relaxed/simple;
	bh=ISaA6t2MIhsbKyxUUczZLBghOiMZSXKAyLBAPWcT0RY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AnRvIB6KaJcQyABSkD2PYd551B6ZwxPh327JDBVV//rtWw26OKFQadkcYOgKtyH/zEQ6dc0x97X49rzQR47q0w6a/l/UO9bqrckmfJQLllxbSDgIaBHmR3i+lE73KCUWwlI6h4FRTNF+C3FUSgAezWXlYxHM0JfoPrJ3psadBlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZPEBDzrC; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5680744457;
	Wed, 19 Mar 2025 20:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742414932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zBYEvxHYDEPHyt7n9KinUMtqyVY5IgTEOKZ+DSUZBS8=;
	b=ZPEBDzrC11BVkharYlDWxfFq8Bf+YYnhBKXIhgz82ouOAuBEOrOpEO9+SwwnM1yp3PSCHi
	roOzJJrTIZkj6gE/1+gxoWDR7YoQBtxstpRrtZkr5WcE5UIv+LBJh7GcthOYBLvEFcY3mF
	amZtRFkEC0hmAAIawVtdnw8cHEvhRcA3VatuCTkztynaa81eH58DqXQvysC6r5GH8BYum5
	Z51R9nRN3uQBFs3Ku+5+T377GwEDGU45Q38gqv6jyVBAZHyAX7k+m02k6qGVaaLBFjnSL9
	3K4gz8Nux9B9Uu8rMF0a4TriYqRnUhdVopAtpDguRxr161L+HVcNkJe02A/yJA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,  linux-spi@vger.kernel.org,
  Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Pratyush Yadav <pratyush@kernel.org>,  Michael Walle
 <michael@walle.cc>,  linux-mtd@lists.infradead.org,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH] spi: spi-mem: Introduce a default ->exec_op() debug log
In-Reply-To: <a97f8ddc-c9b9-45a4-bef3-cbc01c3d07c6@sirena.org.uk> (Mark
	Brown's message of "Wed, 19 Mar 2025 17:39:50 +0000")
References: <20250305201140.2513431-1-miquel.raynal@bootlin.com>
	<a073191e-afab-484e-9659-66b957301db1@linaro.org>
	<ce648080-2964-40d2-a2a7-cafcb6592cd1@sirena.org.uk>
	<87h63p2c3n.fsf@bootlin.com>
	<a97f8ddc-c9b9-45a4-bef3-cbc01c3d07c6@sirena.org.uk>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 19 Mar 2025 21:08:50 +0100
Message-ID: <87ldt0ye99.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeeivdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhephfelkedvveffleeuhfeigfdvvefhgfejgffghfeiteegteeiudegfedtjeehkeefnecukfhppeelvddrudekgedrleekrddukeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledvrddukeegrdelkedrudekledphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepledprhgtphhtthhopegsrhhoohhnihgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtuhguohhrrdgrmhgsrghruhhssehlihhnrghrohdrohhrghdprhgtphhtthhopehlihhnuhigqdhsphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhitghhrghrugesnhhougdrrghtpdhrtghpthhtohepvhhighhnvghshhhrsehtihdrtghomhdprhgtphhtthhopehprhgrthihuhhsh
 heskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhitghhrggvlhesfigrlhhlvgdrtggtpdhrtghpthhtoheplhhinhhugidqmhhtugeslhhishhtshdrihhnfhhrrgguvggrugdrohhrgh
X-GND-Sasl: miquel.raynal@bootlin.com

On 19/03/2025 at 17:39:50 GMT, Mark Brown <broonie@kernel.org> wrote:

> On Wed, Mar 19, 2025 at 05:56:28PM +0100, Miquel Raynal wrote:
>
>> I'd say that for this particular purpose I do not thing that trace
>> printks or events would really fit. As a developer, I'd definitely
>> always change the function calls to some direct printk calls in this
>> case. The verbose debug alternative seduced me though, so if that's okay
>> for you, I'll switch to dev_vdgb() as suggested by Tudor, which honestly
>> feels like a seducing alternative.
>
> That's fine for me.  I do have to say that I tend to end up doing the
> opposite of you and adding tracepoints to code I'm doing much with, they
> work so much better so long as you can get the buffer off the device.
> Low overhead, much bigger lookback and better tooling.

Interesting. Maybe I should consider playing a bit more with those. It's
true that the fact that you need to load the trace buffer off is always
a bit painful, but as long as network works, that should not be that
much of a burden once it's been set up.


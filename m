Return-Path: <linux-spi+bounces-7282-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C7FA6C375
	for <lists+linux-spi@lfdr.de>; Fri, 21 Mar 2025 20:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70ABA1893552
	for <lists+linux-spi@lfdr.de>; Fri, 21 Mar 2025 19:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB41422D781;
	Fri, 21 Mar 2025 19:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Cjevwm9Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v0fCPNtO"
X-Original-To: linux-spi@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BEE33F6;
	Fri, 21 Mar 2025 19:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742586169; cv=none; b=g7NKfPo+jJhntXKbnLGhDsLD2B7Fu6VIgS0UnS3uSNoEqWj62HeB1Z322FJsYEg0NTjhaLohNUl0D8suwMb6qNURW1A6a3qkio67sX4N6yXbkND1+ZHFr1Bx9ug59JmPS5R6YxzUdNm4cWmCMz9Mqj6FIoKPWVHztxNHWh8Ypek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742586169; c=relaxed/simple;
	bh=mc50hpMKW5dLcjzLagI7aCK3wMHZ6+ZcRGfB7C/CSgg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=QXGbow41iDHkQ8772v9v+Q6ezhXqqdeuzsnSx3AKP115y5q6gVWiggRcy8Ox79L4L564edzM4TNan0u9dOyYXwCgpIR9+VxJJe6R9Vcg0kVdH0akX588Ob7rGaTuz4jFrkVCzx9sH5UFHSozUBxtAl7ath2kFjV2gZ5FJ0wiVX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Cjevwm9Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v0fCPNtO; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2622B2540111;
	Fri, 21 Mar 2025 15:42:46 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-07.internal (MEProxy); Fri, 21 Mar 2025 15:42:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742586166;
	 x=1742672566; bh=tZ1+6BEV5F/qIoEDr0T/aw3sWhLcMuYSbfMweqILlXE=; b=
	Cjevwm9Z1coLMcFpiG3N+zXSVgR3Uu5NsylRIGHQk+dHmfdtnxJwIYGDfKCp3o+X
	XEQ2DF1L83p6I8r+BKfrE3MiHvTYieyI07yBbExEwMJ1/0mlO91ljWir6pOamnmE
	vPR5EXtjOMC8vgJ51BFhGN/jLbHESskvePmIINpplj3KY/clTK6rbDQmyqgozibT
	wm+/lUuYg+yvu0+7ov+JjzMfFBsheQpSNLYNQnxpt1LwQVehxMoiXn/EjSO0RK1g
	pbI/5XRw/Z5ueQAgRTF0lvGZaxe6UA4YB+O8Xddrngetc4ifWfrl86djwlIDBg//
	P8U02Ajs7UtXNQSkYxGAYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742586166; x=
	1742672566; bh=tZ1+6BEV5F/qIoEDr0T/aw3sWhLcMuYSbfMweqILlXE=; b=v
	0fCPNtOVjPYKQF0xvEsO+pL7hu7tKVLQRJEBKcibWEi3DHjaXB7PgfG10jy8saCS
	KVjloqGK3bwSd4f3054feYTIhuMMDKzv/l2muWz3xoa4erywMKfQF6zepYEAujzs
	nMYhBFZQNrFVP9u/oRXRWgAu9mx6FRKAMqDwAUoToqHusnd8hx3oJFHTGzgdTMbh
	OKwBWvIc1xNyF7iNBNzl226w8s96iVGjMWqLtBeXDjd8/nv8vsG9/r+ToAE4js2F
	ndTvxmR4ynnzpNsW3aD9pg8D+GglndjzCAmBqTI32cnymuK8dDN+sIuLR7+nhlJL
	SJ48Tk9lWsB/0DcW4U5DA==
X-ME-Sender: <xms:NcHdZ3ahyz-P62nUft5sy6JWKH6GbVqXzVZ1dX6CCdaYEEb_mK2fpA>
    <xme:NcHdZ2bfgZEX4FUU69ywquZndtkaLxbfsfQUV6rPDHrzoM_wofB7fL1x0nAVEa114
    gEm2QYYTWvrvSzPiM0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheduleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeet
    fefggfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohep
    hedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepghhrrghnthdrlhhikhgvlhihsehsvggtrhgvthhlrggs
    rdgtrgdprhgtphhtthhopehpthgvshgrrhhikhesshhushgvrdgtohhmpdhrtghpthhtoh
    eplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheplhhinhhugidqshhpihesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:NcHdZ58aagBbsEYBykOQQoflo_yd7rGwK9D6onul3AraN4P3Us2fbw>
    <xmx:NcHdZ9qbjzJ9CLlFS5w6pwJijBCyKrT4j5wrb0lux6UQv2ttjv0h-w>
    <xmx:NcHdZyr8ZoJ2z_qAWWUxSwMnBjaBSud0Ye9rwZXTEzZPJLu6nPkE4Q>
    <xmx:NcHdZzS2BXDZ41YAd5j5FvhoO3iB0anuksXB5MNcwPRADaX8TJ52Dw>
    <xmx:NcHdZ7m3urxEkasEu7WawyRpJNd9DWRpA8s-KkvWmK0PqKc0ZmtpCNts>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 90D0A2220072; Fri, 21 Mar 2025 15:42:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T6af0c8f44e761c09
Date: Fri, 21 Mar 2025 20:42:12 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Mark Brown" <broonie@kernel.org>
Cc: "Petr Tesarik" <ptesarik@suse.com>,
 "Grant Likely" <grant.likely@secretlab.ca>, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org
Message-Id: <6a3a4b10-f51b-43e2-8281-057f6751424b@app.fastmail.com>
In-Reply-To: <Z917hRQM2ZhSwvFx@finisterre.sirena.org.uk>
References: 
 <1359268504-24937-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20130205142128.2E28D3E1265@localhost>
 <20250320124330.480d652d@mordecai.tesarici.cz>
 <ca70e24d-57b6-4250-bd0d-7f5c72e1d282@sirena.org.uk>
 <b37480a4-5344-4cf4-8fd1-400e2588fc28@app.fastmail.com>
 <db36bbf0-0ad5-4c37-bfcc-917508805eba@sirena.org.uk>
 <efe910db-77d0-4ddf-8fc2-df4955e7b9f3@app.fastmail.com>
 <06435855-531b-4a3b-9f2e-1a5caea0d65b@sirena.org.uk>
 <38fe54d2-bd8a-4655-863d-cd1c482ac9a8@app.fastmail.com>
 <Z917hRQM2ZhSwvFx@finisterre.sirena.org.uk>
Subject: Re: [PATCH] spi: Ensure memory used for spi_write_then_read() is DMA safe
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Mar 21, 2025, at 15:45, Mark Brown wrote:
> On Fri, Mar 21, 2025 at 01:41:52PM +0100, Arnd Bergmann wrote:
>> On Thu, Mar 20, 2025, at 19:39, Mark Brown wrote:
>
>> which happens in a number of drivers but is harmless as long
>> as the driver doesn't actually try to DMA into that buffer.
>
> Hrm, right.  I think that usage is reasonable so we probably should
> allow it rather than forcing things to do an allocation for a transfer
> that ends up being PIOed anyway almost all the time, OTOH the same API
> is also used for large transfers like firmware downloads where we don't
> want to trigger a spurious copy.  Having different requirements at
> different times would be miserable though so I think we need to just
> accept any buffer and then figure it out inside the API, but I've not
> fully thought that through yet.

My feeling so far is that we want the default regmap interface
to just take any buffer (stack, misaligned, vmalloc, kmap) and
leave it up to the underlying bus to make sure this works in
a sensible way.

Using dma_alloc_noncoherent() should make the implementation
much nicer than GFP_DMA in the past, so we could add a bus
specific helper for SPI that checks if the controller actually
wants to do DMA and whether the buffer is problematic at all,
and then decides to either allocate a bounce buffer and
fill the sg table with the correct DMA address, map the
existing buffer, or pass it without mapping depending on
what the device needs.

      Arnd


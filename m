Return-Path: <linux-spi+bounces-7257-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B25A6AB1A
	for <lists+linux-spi@lfdr.de>; Thu, 20 Mar 2025 17:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA6193AB457
	for <lists+linux-spi@lfdr.de>; Thu, 20 Mar 2025 16:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07601EB5E0;
	Thu, 20 Mar 2025 16:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="TbJSHnep";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="3DKUZmtu"
X-Original-To: linux-spi@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F421E25FA;
	Thu, 20 Mar 2025 16:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742488245; cv=none; b=oD6sBW2aSOEGDVwqxDV07GwwvDc+JmR1r06DSMaap6SKU895SFyOhnQIF4287qTl1n1LDtyjKPBhmm0jnh3OyuW0DZKrS2q99qsJfCvOIG0Ez1gWqWMhTwJ/tR6eNAtSDa4SHmlnwH2e3wRz1vur9EI6dPAeH+ZRc4UXmJ/L7z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742488245; c=relaxed/simple;
	bh=BHivrOxBWXgpQ2Qkyf5uKnPvePmfhjahgzYNxwnvgxs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ZxBkPWSD/bhH9jSZ5MPpebb2vXs/i7nz2uIBA2YDjSSLmBeCQ2hbS8fL0fVT1wWlmALEbxbDl2YFmgYumIZzACagA2G9RmTZgUySFnPmIfpb6877XObt9lnUQ2f448azRWKcX9jB8uzA6iWyVBRbSzc/66ORCG4iAPT9hEDK8e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=TbJSHnep; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=3DKUZmtu; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 7EF1E11401BC;
	Thu, 20 Mar 2025 12:30:42 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-07.internal (MEProxy); Thu, 20 Mar 2025 12:30:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742488242;
	 x=1742574642; bh=uo+XX4cyhKiRxGLv7AY3F164TXma7z08UisUC+nuz1Q=; b=
	TbJSHnepOMLAoWG+oPR3oCOOk1Bvtg3OliBmew69c26wlGAyvw7wXvw56Nzujo0X
	892EhO9SqV7TjsZrOtXzONDX+IEOMsJK+HLWICDMunMtFqgxL2LzQTtQgIKDt08A
	TWp6mMj4QSMFXoL9QDXCiBOaowMNIJc7cak2EYLa3KqmZFojwnHeoRaDisSSeeFL
	tsVX7agAHZiVrk1FhW7y5thpnJLqLta71wI7+ZV7IYBoX2g8FvwPOw4GM12yq61T
	hUaSHKl+Tdf7Wfx8MLDG7KgVFSQeIhTk5RwzTHoU6ez2ZOs2C4xby1uxnz9X2b8k
	ESB2v269jG4N0uUoezKy6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742488242; x=
	1742574642; bh=uo+XX4cyhKiRxGLv7AY3F164TXma7z08UisUC+nuz1Q=; b=3
	DKUZmtuny24DSkd7h0EMrywIWhkZ9wA4Rknb8dTFF7W0/I6F6DLtfzBddlvjunhb
	eodfjJylNmNk42FXea5wqMuDQYGGo4R2MC/Hcrf9ZJfJH/keSVkTE4VsCRSwyBnN
	9vupvPgZV78HV8IkTdZfefVx0xjePs1+AuKwPvlOrTBBpJ3nfSVDxnFcMTG0PhAG
	Fp+MJMux/8ef2pmanSpspSlYSWBa6ZSw06BvPPpQnIE9whtTp/mh4s6HGNtrJjkj
	OdGRiMMOZt+j+gBQBgDGxAN1eigfp0LYR5WDUhwi2Q3QPYCqBujl15s32GhPSdrE
	LdbbuVkvbxKmiixilMPOQ==
X-ME-Sender: <xms:sULcZ_pRmvVBfu800I3i5v1dwDXA9Kqd2CEoR7HWVjy7q96M7yStJg>
    <xme:sULcZ5qfyd6YGWukM_AHEyQRPvr6Gp3ENuVZ4S8jUlXDc-oGTUTUlLxNwhrMz-385
    VR0_BdSbjYlGnF2-t4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeekieelucetufdoteggodetrf
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
X-ME-Proxy: <xmx:sULcZ8Oolaa-t68dBBdBFEePDdGMOVTsm6HO1ENjNjCAlCwORUwRfw>
    <xmx:sULcZy55_1WR1-pwiJYUlIBNeLxHhB40mjWJD5JVSFJLk8An-nVtUw>
    <xmx:sULcZ-6wUfuPN8R_Tuzwn1Ojn1A076234tEdd84dmLLYRQSY5m3KAw>
    <xmx:sULcZ6jFDGeBCW3Q-Us-t-PZ-qt3C1hLofZ1fGCvauGWHTezfDIyhg>
    <xmx:skLcZ50sbubEzst7DLlRz3J_rjhsrR7z18cU-6rU7zztW7sRaFtwmGuh>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D126E2220072; Thu, 20 Mar 2025 12:30:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T6af0c8f44e761c09
Date: Thu, 20 Mar 2025 17:30:01 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Mark Brown" <broonie@kernel.org>
Cc: "Petr Tesarik" <ptesarik@suse.com>,
 "Grant Likely" <grant.likely@secretlab.ca>, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org
Message-Id: <efe910db-77d0-4ddf-8fc2-df4955e7b9f3@app.fastmail.com>
In-Reply-To: <db36bbf0-0ad5-4c37-bfcc-917508805eba@sirena.org.uk>
References: 
 <1359268504-24937-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20130205142128.2E28D3E1265@localhost>
 <20250320124330.480d652d@mordecai.tesarici.cz>
 <ca70e24d-57b6-4250-bd0d-7f5c72e1d282@sirena.org.uk>
 <b37480a4-5344-4cf4-8fd1-400e2588fc28@app.fastmail.com>
 <db36bbf0-0ad5-4c37-bfcc-917508805eba@sirena.org.uk>
Subject: Re: [PATCH] spi: Ensure memory used for spi_write_then_read() is DMA safe
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Mar 20, 2025, at 15:42, Mark Brown wrote:
> On Thu, Mar 20, 2025 at 02:35:41PM +0100, Arnd Bergmann wrote:
>> On Thu, Mar 20, 2025, at 13:29, Mark Brown wrote:
>
>> > On a lot of systems most transfers are short and won't be DMAed at all
>> > since PIO ends up being more efficient, and most hardware is perfectly
>> > happy to DMA to/from wherever so *shrug*.  SPI_BUFSIZ is a maximum of 32
>> > bytes which is going to be under the copybreak limit for quite a few
>> > controllers, though admittedly 16 is also a popular number, so a lot of
>> > the time we don't actually DMA out of it at all.
>
>> I saw the same thing looked at it the other day and got confused
>> about why 'local_buf' is allocated with GFP_DMA and 'buf'
>> uses plain GFP_KERNEL when they are both used in the same place.
>
> Really we just don't expect the small buffer to be DMAed.

I looked at a couple of drivers and found many have a copybreak
limit less than SPI_BUFSIZE

#define SPI_BUFSIZ      max(32, SMP_CACHE_BYTES)

drivers/spi/atmel-quadspi.c:#define ATMEL_QSPI_DMA_MIN_BYTES    16
drivers/spi/spi-at91-usart.c:#define US_DMA_MIN_BYTES       16
drivers/spi/spi-atmel.c:#define DMA_MIN_BYTES   16
drivers/spi/spi-davinci.c:#define DMA_MIN_BYTES 16
drivers/spi/spi-stm32.c:#define SPI_DMA_MIN_BYTES       16
drivers/spi/spi-imx.c:  .fifo_size = 8,

so any transfers from 17 to 32 bytes would try to use the
non-GFP_DMA 'buf' and then try to map that.

>> It also seems that the copy happens in the regmap_bulk_read()
>> path but not the regmap_bulk_write(), which just passes down
>> the original buffer without copying, as far as I can tell.
>
> Yes, writes don't need to do anything.

Can you explain why writes are different from reads here?

>> I think we have some corner cases where a driver allocates
>> a GFP_DMA buffer, calls spi_write_then_read through regmap,
>> which copies the data to the non-GFP_DMA global buffer,
>> and then the SPI controller driver calls dma_map_single()
>> on that, ending up with a third bounce buffer from
>> swiotlb.
>
> I suspect that practically speaking almost everything will be under the
> copybreak limit.  Probably we should just make regmap use spi_sync()
> with the supplied buffers here and avoid spi_write_then_read().

I'm a bit lost in that code, but doesn't spi_sync() require
a buffer that can be passed into dma_map_sg() and (in theory
at least) GFP_DMA?

Based on what I see, every SPI transfer code paths goes
through __spi_pump_transfer_message() and spi_map_msg(),
which then tries to map it. This means two things:

- any user passing 17 to 32 bytes into the read function
  either works correctly because the GFP_DMA was not needed,
  or it's broken and nobody noticed

- the way that spi_map_buf_attrs() is written, it actually
  supports addresses from both kmap() and vmalloc() and
  will attempt to correctly map those rather than reject
  the buffer. While this sounds like a good idea, handling
  vmalloc data like this risks stack data corruption
  on non-coherent platforms when failing to map stack
  buffers would be the better response.

>> I don't know what a good replacement interface would be, but
>> ideally there should never be more than one copy here,
>> which means that any temporary buffer would need to be
>> allocated according to the dma_mask of the underlying
>> bus master (dmaengine, spi controller, ...).
>
> Which is a pain because even if you've got the device for the SPI
> controller there's no way to discover if it does it's own DMA.

__spi_map_msg() already handles the case of an external
DMA master through ctlr->dma_map_dev, so I think the same
could be used to get a temporary buffer using
dma_alloc_noncoherent() inside of spi_write_then_read()
in place of the kmalloc(, GFP_DMA).

      Arnd


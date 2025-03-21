Return-Path: <linux-spi+bounces-7271-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6472BA6BAEA
	for <lists+linux-spi@lfdr.de>; Fri, 21 Mar 2025 13:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DBB3483B52
	for <lists+linux-spi@lfdr.de>; Fri, 21 Mar 2025 12:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C582228CBE;
	Fri, 21 Mar 2025 12:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="aOq0QIWA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZBxiOA53"
X-Original-To: linux-spi@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD9E225797;
	Fri, 21 Mar 2025 12:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742560935; cv=none; b=KODkdJusfdEltybkdDpYE522BYiHSeNDw2Ulx7W9xeurOGUxeT5aAdw83D+l0E6yezeNL9hdlyxpNH/aC3f/FHa35Ujr3M6Y5TFHlZnTCgAnsuFRXevS/KL3TG5BbndAP077/SBBpNIab1r/HaJuQnsydIL65Nmiy8+V2W2EZ8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742560935; c=relaxed/simple;
	bh=Yh/egioEWiHeLaE9RitSltzw5vvw4bd8EWxIUPESF9w=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ZWZAOsI3mFISehsiJ8hG/0DYiXBBbVBY0HjCSz6v2CzPzDH1NQo47VvXA7QYDAOjfwxCsifOdUfD08QcX0WgdS7ViuS1wCOb+AD6PgRQniyu4AB/lRpnPvcznAYVf4+eY0r785f63x8KaLXNRedi+/r4cniFEzptWltZhQYehlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=aOq0QIWA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZBxiOA53; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 1167B1382CFB;
	Fri, 21 Mar 2025 08:42:13 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-07.internal (MEProxy); Fri, 21 Mar 2025 08:42:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742560933;
	 x=1742647333; bh=KAoNEwz13/alp5/mJu53PYiMdMj2081dmf8VGcuNFRg=; b=
	aOq0QIWAJA8L/PQYlprrmnpa4HD18xIstuyFvLEb3sQGg8JZZN7UJMJtn377bb46
	VDejqr/THy6UUx03D5MnEazj8Bo2b02ocLbLFKwxHWcaXrCXsvBA3b8wHFihsBnD
	B+n5Q0EkAaem2CGqjkf01DRy7Go2lT0EmeksAWwBHGrldiM2q9/jVx3gWMIzxtCH
	rEjQpDM9IoZ9CIdMfjaRUfi4hHS5RRekRfLhOlzVLqYRJsE6zKQhpDab/28k407M
	0oOj9QKJURkNes6Sl56vLhPimAmSDiqRt7rYmZvv+DZFGx9KJ9rUW36uhmSYz6be
	+2NU7OEdl9bziJtRdWxv4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742560933; x=
	1742647333; bh=KAoNEwz13/alp5/mJu53PYiMdMj2081dmf8VGcuNFRg=; b=Z
	BxiOA53GGvCX3z54Gy76bQUKTiDzpohR5mbj+YkKTaN3p/tbnWWHl5qEYMuA0vUm
	lcEYI7Q+s0ZSRMT5xssjcmHIly3WWi6nrr9UAWP9xT6mphmtWn1P2jPvuEcg46QX
	Mdxz0zg/xf4swh4v7AXIyC3Eb2r2rYUg8r+u1R1+9K3/yxBS+KleIeWwwAD1Nxla
	xG9IHtH4bw804jNrge1szOn4VMhiorPGOkDaksQx49hIK32NfpLDwp6rZg5OwDgy
	8kuWLqVbe8Ve2bFzJ5O10E4Tf0PeUddZ5ZRKBcsfX0RIjNvyXYb/u2yxgECFD7dQ
	WAWeLUAwrCZArkpMyvvVQ==
X-ME-Sender: <xms:pF7dZx7t7GOTQKyeC7wmVncN6xUUJnlNgsI2Vuwx3wfBAk9JoTSXTw>
    <xme:pF7dZ-4FiExCjauzT9aGm_JsCsvuNWXA3Msj7-JW3Diog7o9cMq0XwJTJLc9X1Nao
    _zBNuRbiSCOZGECrJo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheduudefucetufdoteggodetrf
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
X-ME-Proxy: <xmx:pF7dZ4eyBp7Qhxnb93zCdrF48Qen-ReRJf4DwiYaPUCrVOlY0GAMlg>
    <xmx:pF7dZ6K5ljgEWLZ1zlGsjQCbZwRlsJSd6wYz7m0AwVOHKnitpowfMA>
    <xmx:pF7dZ1JakFxEsPt-KwW8x9BcVH1Smfdz9-4t5gm-Ydj2NXwNMi6Jlg>
    <xmx:pF7dZzy9Gvtori4I5v6llpPTiyQkdpsZVmVCJPg0HkQVLN9Md6kiIA>
    <xmx:pV7dZyFL4B1NxLHOuvmwDl9RAz2RHL-xlYf06RjCFNeeES9s7h9fQABl>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B66CF2220072; Fri, 21 Mar 2025 08:42:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T6af0c8f44e761c09
Date: Fri, 21 Mar 2025 13:41:52 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Mark Brown" <broonie@kernel.org>
Cc: "Petr Tesarik" <ptesarik@suse.com>,
 "Grant Likely" <grant.likely@secretlab.ca>, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org
Message-Id: <38fe54d2-bd8a-4655-863d-cd1c482ac9a8@app.fastmail.com>
In-Reply-To: <06435855-531b-4a3b-9f2e-1a5caea0d65b@sirena.org.uk>
References: 
 <1359268504-24937-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20130205142128.2E28D3E1265@localhost>
 <20250320124330.480d652d@mordecai.tesarici.cz>
 <ca70e24d-57b6-4250-bd0d-7f5c72e1d282@sirena.org.uk>
 <b37480a4-5344-4cf4-8fd1-400e2588fc28@app.fastmail.com>
 <db36bbf0-0ad5-4c37-bfcc-917508805eba@sirena.org.uk>
 <efe910db-77d0-4ddf-8fc2-df4955e7b9f3@app.fastmail.com>
 <06435855-531b-4a3b-9f2e-1a5caea0d65b@sirena.org.uk>
Subject: Re: [PATCH] spi: Ensure memory used for spi_write_then_read() is DMA safe
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Mar 20, 2025, at 19:39, Mark Brown wrote:
> On Thu, Mar 20, 2025 at 05:30:01PM +0100, Arnd Bergmann wrote:
>> On Thu, Mar 20, 2025, at 15:42, Mark Brown wrote:
>
>> drivers/spi/atmel-quadspi.c:#define ATMEL_QSPI_DMA_MIN_BYTES    16
>> drivers/spi/spi-at91-usart.c:#define US_DMA_MIN_BYTES       16
>> drivers/spi/spi-atmel.c:#define DMA_MIN_BYTES   16
>> drivers/spi/spi-davinci.c:#define DMA_MIN_BYTES 16
>> drivers/spi/spi-stm32.c:#define SPI_DMA_MIN_BYTES       16
>> drivers/spi/spi-imx.c:  .fifo_size = 8,
>
>> so any transfers from 17 to 32 bytes would try to use the
>> non-GFP_DMA 'buf' and then try to map that.
>
> Yes, like I said elsewhere in the thread 16 is a popular number but I
> suspect that was the thining there.

Ok, so do we assume we don't need the GFP_DMA then? That's
fine with me, but in that case we should probably enable
swiotlb on all arm32 platforms that may have ZONE_DMA smaller
than ZONE_NORMAL.

>> >> It also seems that the copy happens in the regmap_bulk_read()
>> >> path but not the regmap_bulk_write(), which just passes down
>> >> the original buffer without copying, as far as I can tell.
>
>> > Yes, writes don't need to do anything.
>
>> Can you explain why writes are different from reads here?
>
> I think there may have been some context lost there while replying?

I found the answer now: at least on common architectures (arm,
powerpc, mips, ...), doing a write from an unaligned buffer
on stack or in a shared data structure won't cause data corruption,
but doing a read into that buffer can end up throwing away
data that shares the same cacheline.

>> > I suspect that practically speaking almost everything will be under the
>> > copybreak limit.  Probably we should just make regmap use spi_sync()
>> > with the supplied buffers here and avoid spi_write_then_read().
>
>> I'm a bit lost in that code, but doesn't spi_sync() require
>> a buffer that can be passed into dma_map_sg() and (in theory
>> at least) GFP_DMA?
>
> Yes, it does - the API is in general that the memory be something we
> could DMA, in case the controller wants to.  You'll probably get away
> with just passing whatever for small enough transfers, it's much more
> common to get a controller that won't DMA than one that must DMA.
>
> I think I'd been under the impression that dma_map_sg() would handle
> things similarly to dma_map_single() (it's a bit of a landmine for it
> not to...).  It's a very long time since I looked at any of this stuff.

Yes, dma_map_{single,page,sg} all do the same thing
internally.

>> - the way that spi_map_buf_attrs() is written, it actually
>>   supports addresses from both kmap() and vmalloc() and
>>   will attempt to correctly map those rather than reject
>>   the buffer. While this sounds like a good idea, handling
>>   vmalloc data like this risks stack data corruption
>>   on non-coherent platforms when failing to map stack
>>   buffers would be the better response.
>
> IIRC that's there to support filesystems on SPI flashes or some other
> application that uses vmalloc()ed buffers, it's definitely not intended
> to support data on stack.  If it does anything for stack allocated data
> that's accidental.

Ok, then the question is what we should do about callers that pass
in stack data. I can send a patch that adds a WARN_ONCE() or similar,
but it would trigger on things like 

static int rt1711h_read16(struct rt1711h_chip *chip, unsigned int reg, u16 *val)
{
        return regmap_raw_read(chip->data.regmap, reg, val, sizeof(u16));
}
static int rt1711h_write16(struct rt1711h_chip *chip, unsigned int reg, u16 val)
{
        return regmap_raw_write(chip->data.regmap, reg, &val, sizeof(u16));
}

which happens in a number of drivers but is harmless as long
as the driver doesn't actually try to DMA into that buffer.

>> >> I don't know what a good replacement interface would be, but
>> >> ideally there should never be more than one copy here,
>> >> which means that any temporary buffer would need to be
>> >> allocated according to the dma_mask of the underlying
>> >> bus master (dmaengine, spi controller, ...).
>
>> > Which is a pain because even if you've got the device for the SPI
>> > controller there's no way to discover if it does it's own DMA.
>
>> __spi_map_msg() already handles the case of an external
>> DMA master through ctlr->dma_map_dev, so I think the same
>> could be used to get a temporary buffer using
>> dma_alloc_noncoherent() inside of spi_write_then_read()
>> in place of the kmalloc(, GFP_DMA).
>
> That only helps spi_write_then_read() though.

Right, we'd need to mirror this in other interfaces, either changing
the existing ones, or adding safer ones that can be used from regmap
and from drivers that currently allocate their own GFP_DMA buffers
for this purpose.

      Arnd


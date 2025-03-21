Return-Path: <linux-spi+bounces-7283-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07669A6C50A
	for <lists+linux-spi@lfdr.de>; Fri, 21 Mar 2025 22:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 307DF1B60C6F
	for <lists+linux-spi@lfdr.de>; Fri, 21 Mar 2025 21:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81F1230BF8;
	Fri, 21 Mar 2025 21:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="UAvA5U+N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PSCupRmP"
X-Original-To: linux-spi@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F90122652E;
	Fri, 21 Mar 2025 21:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742592109; cv=none; b=Vr9P2jwUAYTUXuAe4ghfSKFx5aCeLT+9fWHHlEF08e9MyQW22p+2K8qJ2q7fAy2t+Z3Kszz8Yv4/QTsexjVgVORPSWwl9MdPHrVg1udciWk87xKZC9gsZEA9dW1dq0vvUb8YcMFOc0JHs/kNtXWBFrELo9mLE3//bJR/8a3hL+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742592109; c=relaxed/simple;
	bh=lxuRq+sNZMa9/XFmEnAh1+iKajFQmckbPWkXIA8k/q0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=nQetDwpyxvyxpg8vAf8w+LVATCHj6fZdzereCqL4YPe0+BCefyluYskaWsUgPPAYdMq9ZWQylCJAt79+CnpYuoJokFWyiPnrC53j2KQ/ELJD+0JFTnttniLJK3lqfQDXyjUIm5r524kNYfPHmoHgOKfgq1KO0SzvYZpEzInLMRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=UAvA5U+N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PSCupRmP; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 277DB11400A4;
	Fri, 21 Mar 2025 17:21:46 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-07.internal (MEProxy); Fri, 21 Mar 2025 17:21:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742592106;
	 x=1742678506; bh=FoVE/45hwjLJVdzK1hX9tAa7NP3NyI6s9O18QKpCRnk=; b=
	UAvA5U+NQN36SrYtM2sehrKNz6JPFgWmbXAXF8acITOdHUXIUkcaLyj4FL1h2rNK
	arQUvHLSZh6fEbvdZon2BKPiYTCKpnihh9ro0U1TVWNhdS/W8k+wgACqtcea8GeG
	SjriG1Uothnc95b/35AxlGi2lP+PZF382AFdPYFHveRt0xpx7uDvGUPmvdkjLKso
	i81//NLDHQMJ7oPpdYuXktG2ylWVOad4s9wvRzXrx+cD5ais1S03WzwsvkGToSf5
	jEQhMXJAHAdOpYHQbWrj1XAfF2HMic1qFXS0RLOK4PV+8CcFGCNaqPLC41oVuvLy
	vs1pmOeUHbix6v8xU0sGNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742592106; x=
	1742678506; bh=FoVE/45hwjLJVdzK1hX9tAa7NP3NyI6s9O18QKpCRnk=; b=P
	SCupRmP2DB6l1A8TqxZhuTcdy0Rl8T5UPjX6ZRDagyXCwLWqjo3gVYYi3CYZLO/w
	NaDEMrqxqtLCFpuZRsM4CZWlo15yR7MBT1ptnVCHp+BPotcGgeAq8EaB/PQ/7jFF
	2L8lTfSIs1r4oJEZK77qnqBS9hjll/L/9/vEo9R6Z4TMzxvMCh+aCSYtLbMqzLB3
	hHBKms/tDMxbXtreXSKWjRUiJw48bG8SPaLkGo20CACQnF6eiFyS6GI4W678SZR5
	fHhO55msxkDWMjhm05e7eeinpcvEPjKq1wsVfRCzAZFNozI3lQMZsvmXIs5LYjVe
	cNPOeAkewcKXXjfnNipEA==
X-ME-Sender: <xms:adjdZ40FOz0J7tSWiehOzzaLwy-WfMyXYO-BSS-Ws472AivnrBHikQ>
    <xme:adjdZzEnEMVTuxNWmNEvaSjaRQLCP8prr5TZnvqAsDp7Q7Oz1YLW13lZ8nFVe_9ih
    wW2nWLnwx36LhWGjYo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduhedvudehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:adjdZw4OowGGjS1ZGQTbwyLwmC6OCeRFIDmjJzXhVzrlLH3Mz1fK6Q>
    <xmx:adjdZx382I7_kG3oym9X5kZl3CP_nQJ94bnuQ_1ysz4AizWI0NKzQw>
    <xmx:adjdZ7Eq5ZG0NzKwZ7DSKU1A8Lh03ridgAG1-t-9f7Go9-1VPwWsMQ>
    <xmx:adjdZ6_PAF3LnX6n70aK3VDY7_QW7N7iZo_BYnPwYKc-wmo_XmR72A>
    <xmx:adjdZ_h_s8YzkgGAQULtJL6dLjYmY3Z6vIqg93vQG4HqQrENROQO3tWY>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9A6B02220072; Fri, 21 Mar 2025 17:21:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T6af0c8f44e761c09
Date: Fri, 21 Mar 2025 22:21:03 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Petr Tesarik" <ptesarik@suse.com>
Cc: "Mark Brown" <broonie@kernel.org>,
 "Grant Likely" <grant.likely@secretlab.ca>, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org
Message-Id: <b837b2a7-8a88-4782-96d4-1b637bba0664@app.fastmail.com>
In-Reply-To: <20250321151327.4c8f8d4c@mordecai.tesarici.cz>
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
 <20250321151327.4c8f8d4c@mordecai.tesarici.cz>
Subject: Re: [PATCH] spi: Ensure memory used for spi_write_then_read() is DMA safe
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Mar 21, 2025, at 15:13, Petr Tesarik wrote:
> On Fri, 21 Mar 2025 13:41:52 +0100
>> Ok, then the question is what we should do about callers that pass
>> in stack data. I can send a patch that adds a WARN_ONCE() or similar,
>> but it would trigger on things like 
>> 
>> static int rt1711h_read16(struct rt1711h_chip *chip, unsigned int reg, u16 *val)
>> {
>>         return regmap_raw_read(chip->data.regmap, reg, val, sizeof(u16));
>> }
>> static int rt1711h_write16(struct rt1711h_chip *chip, unsigned int reg, u16 val)
>> {
>>         return regmap_raw_write(chip->data.regmap, reg, &val, sizeof(u16));
>> }
>> 
>> which happens in a number of drivers but is harmless as long
>> as the driver doesn't actually try to DMA into that buffer.
>
> This sounds like we should push the WARN_ONCE() one level deeper, into
> the DMA code. That's a good idea, actually, because it's always wrong
> to do DMA to a stack address, not just when SPI does it.

This doesn't work for the current SPI code that uses
vmalloc_to_page() in order to deal with vmalloc addresses.
Passing a vmap stack address in here would continue working
on the address from the linear map.

There is already a check_for_stack() assertion in
debug_dma_map_page(), which is meant to catch this problem
in the DMA layer itself, but only when CONFIG_DMA_API_DEBUG
is enabled.

      Arnd


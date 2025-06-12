Return-Path: <linux-spi+bounces-8472-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 887B5AD6ECA
	for <lists+linux-spi@lfdr.de>; Thu, 12 Jun 2025 13:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17D093A04D1
	for <lists+linux-spi@lfdr.de>; Thu, 12 Jun 2025 11:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846DC23CEE5;
	Thu, 12 Jun 2025 11:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="MCTXa7ei";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dTCct3G8"
X-Original-To: linux-spi@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5658623C51E;
	Thu, 12 Jun 2025 11:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749727037; cv=none; b=EvlUWOkMIrhnae2GxRS2nC46Z6jjv/ZUR/1dghkutqkw5Vix6fKrbRBvZsZbA1zXuNAcoafHUUoDJMEWk/H3DRfVl/tX9GOlPcw/GFnS5/PCkVfIHVrDIn6OOUAbZ9SIpRSVpf3RSzwYMxpbhx17dABm3dWTogTBNPuZyCNN4Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749727037; c=relaxed/simple;
	bh=/ob1+R4rK+evjYyQ9GByv2Tek8HEKPX3CQI3lK8yogc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=rY+TXGiUGStFCpomvWHeDKdXgYedu/Fs7olxRj6GN0iYpf+8paSrYP89REkD1jNOew7aRmJCRikli0ArpB4orCWd7kPk124ulifvPb5TITOEL/xglFVFzB0/Hhg8mx/TPNC46lFaGh/JXxKSP1wO/eYXAiEtXpwkBzHSrleVv3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=MCTXa7ei; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dTCct3G8; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 4FAE91380440;
	Thu, 12 Jun 2025 07:17:14 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Thu, 12 Jun 2025 07:17:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1749727034;
	 x=1749813434; bh=Akc6NrVjz9IseDhIujJxCPwAB8Hadsgbs8m/AeaTufM=; b=
	MCTXa7eiQfCsN4qWW/Aod0S/H/S6b8PkjbtX1QZKgo6oFyLBi4kY6BCI3NeemNtr
	35fuMoSfVhVWD+hnlY1Tefnl5dEXc7LVsMUoi5UyCPBvP9JjsQ/2ZV9iblWwH9JN
	fb/bJd0SnMp3xoQIKfRSCI1haGxRJM8B71P+PUlOTnzswsEwhoZYcZeZ4GPADTp1
	iXDXCgJwELvhLmkw5FEYounFTCjpcwvU0l23ucugf7uxzTA3uErTcGDWE90ZdihC
	bg7TMWDqSuBe2Cz1CcSHLXgAfUVHjq6ab6DVvfhFefbyieC/6CqyBbH5yADWoLmz
	mg9ycZoQIZhetAVlSmyBkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749727034; x=
	1749813434; bh=Akc6NrVjz9IseDhIujJxCPwAB8Hadsgbs8m/AeaTufM=; b=d
	TCct3G8shRUsRRt6Yi4Rz6wrOtCPwcnDPD94IjI95FajbNrvArqbSD/KlTl99D0N
	w3OvTdq5L4EiiSlD8FMUDhrzQOkjyCXtgUanyohRjtPV+hkc9peXsjoyw9wbPsiE
	k3PLP4mtah5jEvRHVfzdNl8GDVDYi425L1OmnGpdR6jypxFRLGwVTwardK/r5jGy
	lZXGOYir0jtocN2qVrwsutw6oCO+UkC/08JO7ewXR5zUgBuDqhhv+IHt6C6uDLF7
	1bBgaZ2XPpc4nxXp5Wv5xOI4BRrx6w0xxAdtbY+uYE6Eg7KOfUl9e/8cj3o1Ld69
	VI8ZlS3wjL2gcvdGnve/g==
X-ME-Sender: <xms:OrdKaEf2yaeMGn2ojVwzGtOc8zu7ch3DQiFQh6BQ2hNMNa2QTA0zVw>
    <xme:OrdKaGPCq8fT9zKn9Uaz5nWjusbhIaJqpfM2rWMbRN-I6Hj_VWKMard778NJHEiVm
    dF-OjIGNydy5KHlqK0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddugeelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeek
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeholhhtvggrnhhvsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepjhgrmhgvshdrtghlrghrkheslhhinhgrrhhordhorhhgpdhrtghpthhtohepihhmgi
    eslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehfrhgrnhhkrdhlihesnhig
    phdrtghomhdprhgtphhtthhopehvlhgrughimhhirhdrohhlthgvrghnsehngihprdgtoh
    hmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheplhhinhhugidqshhpihesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:OrdKaFgOa1me-KdjCnVxcsMd9M-hNdUO0ATAHVI_iNNwwLjxkolnSA>
    <xmx:OrdKaJ-Xew_3gsCafIcDynKd5c4i9HOEOx1aPVgw5DHkBA32A0ixdA>
    <xmx:OrdKaAstsIZ-IAMzFZvJ_bayL4A1Q56tFacr2KQK7iflqxi6yRAPjQ>
    <xmx:OrdKaAGshTIhhfCpZDkn52Ipnf6clQrbL-P0zcO7DerC8PsIgzhDgg>
    <xmx:OrdKaKFsUt5hutpYek-P1YJWWoYctQ1w6yC-j2q69brnnzC9bjoZWQR->
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id EBD10700062; Thu, 12 Jun 2025 07:17:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T7ec8a5524929d219
Date: Thu, 12 Jun 2025 13:15:46 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "James Clark" <james.clark@linaro.org>,
 "Vladimir Oltean" <vladimir.oltean@nxp.com>, "Frank Li" <Frank.li@nxp.com>
Cc: "Vladimir Oltean" <olteanv@gmail.com>, "Mark Brown" <broonie@kernel.org>,
 linux-spi@vger.kernel.org, imx@lists.linux.dev, linux-kernel@vger.kernel.org
Message-Id: <e8752d90-5087-4b02-92bc-b3636b5e705d@app.fastmail.com>
In-Reply-To: <c65c752a-5b60-4f30-8d51-9a903ddd55a6@linaro.org>
References: <20250609-james-nxp-spi-dma-v1-0-2b831e714be2@linaro.org>
 <20250609-james-nxp-spi-dma-v1-2-2b831e714be2@linaro.org>
 <aEhMBsqlx9I4XqJS@lizhi-Precision-Tower-5810>
 <de7142ac-f1a3-412f-9f00-502222b20165@app.fastmail.com>
 <aEhVsrEk0qv+38r3@lizhi-Precision-Tower-5810>
 <20250611090107.t35zatn47vetnvse@skbuf>
 <c65c752a-5b60-4f30-8d51-9a903ddd55a6@linaro.org>
Subject: Re: [PATCH 2/4] spi: spi-fsl-dspi: Use non-coherent memory for DMA
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Jun 12, 2025, at 13:05, James Clark wrote:
> On 11/06/2025 10:01 am, Vladimir Oltean wrote:
>> On Tue, Jun 10, 2025 at 11:56:34AM -0400, Frank Li wrote:
>>> Can you add performance beneafit information after use non-coherent memory
>>> in commit message to let reviewer easily know your intention.
>> 
>> To expand on that, you can post the output of something like this
>> (before and after):
>> $ spidev_test --device /dev/spidev1.0 --bpw 8 --size 256 --cpha --iter 10000000 --speed 10000000
>> where /dev/spidev1.0 is an unconnected chip select with a dummy entry in
>> the device tree.
>
> Coherent (before):
>
> rate: tx 385.8kbps, rx 385.8kbps
> rate: tx 1215.7kbps, rx 1215.7kbps
> rate: tx 1845.2kbps, rx 1845.2kbps
> rate: tx 1844.0kbps, rx 1844.0kbps
> rate: tx 1846.1kbps, rx 1846.1kbps
> rate: tx 1844.8kbps, rx 1844.8kbps
> rate: tx 1844.4kbps, rx 1844.4kbps
> rate: tx 1846.9kbps, rx 1846.9kbps
> rate: tx 1846.5kbps, rx 1846.5kbps
> rate: tx 1843.2kbps, rx 1843.2kbps
> rate: tx 1844.8kbps, rx 1844.8kbps
> rate: tx 1845.2kbps, rx 1845.2kbps
> rate: tx 1846.5kbps, rx 1846.5kbps
>
> Non-coherent (after):
>
> rate: tx 314.6kbps, rx 314.6kbps
> rate: tx 748.3kbps, rx 748.3kbps
> rate: tx 1845.2kbps, rx 1845.2kbps
> rate: tx 1849.3kbps, rx 1849.3kbps
> rate: tx 1846.1kbps, rx 1846.1kbps
> rate: tx 1847.3kbps, rx 1847.3kbps
> rate: tx 1845.7kbps, rx 1845.7kbps
> rate: tx 1846.5kbps, rx 1846.5kbps
> rate: tx 1844.4kbps, rx 1844.4kbps
> rate: tx 1847.3kbps, rx 1847.3kbps
> rate: tx 1847.3kbps, rx 1847.3kbps
> rate: tx 1845.7kbps, rx 1845.7kbps
> rate: tx 1846.5kbps, rx 1846.5kbps
>
> Ignoring anything less than 1800 as starting up, coherent has an average 
> of 1845.2kbps and non-coherent 1846.5kbps. Not sure if that's just noise 
> or an actual effect.

The extra cache flushes do introduce some overhead as well, so I
would expect the noncoherent case to be slightly slower for
small transfers, but the coherent case to be faster for large
transfers.

"--size 256" presumably means 256 bytes, i.e. four cachelines?
If it's easy to reproduce, can you check with smaller sizes
that still use the DMA codepath (e.g. 64 bytes) and much larger
transfers (e.g. 2048 bytes)?

      Arnd


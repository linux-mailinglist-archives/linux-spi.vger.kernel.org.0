Return-Path: <linux-spi+bounces-7212-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C1BA67DBA
	for <lists+linux-spi@lfdr.de>; Tue, 18 Mar 2025 21:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AC4D3B7427
	for <lists+linux-spi@lfdr.de>; Tue, 18 Mar 2025 20:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B981F4C94;
	Tue, 18 Mar 2025 20:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Wa6G3XdC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JgXMCynC"
X-Original-To: linux-spi@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6461DC9BA;
	Tue, 18 Mar 2025 20:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742328473; cv=none; b=AEGW+yjYcnfTly0gOyhi/8EqVKF3dJ23vfqfKPXg4XdumQXbz6KfEU6rmhUiHViY7iWgf4ZJiGGjP5yAjDq/STp4XcT3E+/VlmWFyQGZzMTpJvfO9/8wv3jTPLaC89J4HfN0TKGctX+YRg0mNVO4URVoZjouyxxZZGqjxJtZ4JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742328473; c=relaxed/simple;
	bh=b+GkVTVPdGMjesdH6roRJPL1rMkE7RQF6/rr9WZywxU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=NerkkefF71o5fWQechtxNEUE0H2JvbxdZ6oVsDFSBXJMIZc9z+c/5rmVSJHawdxFHFkfV6zrj4T0nY2JVWH35V4l7JbOi+81RnOmUqWScb2gHhjHhpba6G6r9aNvj/0tcVKpSiOKO9S4NO3h+L4e25Lee9VClHz31fl+B/Vsix4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Wa6G3XdC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JgXMCynC; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7DFEB11401BA;
	Tue, 18 Mar 2025 16:07:49 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-07.internal (MEProxy); Tue, 18 Mar 2025 16:07:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742328469;
	 x=1742414869; bh=WkPt1j2YvUBVtY8MndwTQrQ/WFhEaBCQORkXakLQz2A=; b=
	Wa6G3XdC1qGAiYU4KHemJv6ugYF6qLQPvbqAnpmssz9SDViP28TXWxTaEWLxr9fu
	WpWmmNVqIMwWKozrcOR+aXc6d0Q5ex/LjaatQDUZ0EkKh3TJsrXlu3emb26+lnLh
	R9ApHSKejtoA7Ci5GDtBA9fabU8ZC60uNd0nLr6S0xaOUMqpNndAv8ztfiO3RSIJ
	SEqzYj9MO43LQ1TK3qu2z3v84Ni4brQuV6j+CfiupN25jIUpNLxTciKJ6/i7Xa5t
	S9LlnBVVpIDg6Jxo0VqQXqXIuZUOsBCd9J5Xgti/1mGpNSw/1iZhq4ucOy9198bV
	L/QAYE1jfNZY5diMC2GZLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742328469; x=
	1742414869; bh=WkPt1j2YvUBVtY8MndwTQrQ/WFhEaBCQORkXakLQz2A=; b=J
	gXMCynCO0TMtBvuNl902cmlUZzNKJUoGj/8ZWye4wVjf7NnzqUlliFOFHTIFvPaQ
	Yu5T1V/zdNYfgJnutUmAy4UwRAtjCN3Aw8OLCFNelfgrjSBhtEUgyAlRDrfwrbEx
	x/LLrPe4QmXCiqj1I0jXjpyLE2bGbTnZIOtMx0IcFjpVWfTVxEjAjTyvZRDv8RFX
	jqhRH2t26J0s0WIKItyTaVhzvmYX84adCnrfwWiO9Qkwyi2MpHGQf9m23gGZIMSo
	4J9WqLyz9Dbzqjs4HT4VZnbyulT5csOG9jjCQQsZwMyGhlkIzmTOfPjpECGfc6co
	K8RK6fa8VWV0+8xCCaxzA==
X-ME-Sender: <xms:lNLZZ1RvQIlI2l9piKL0B_K6httTa77aXMDRCsPhxDXWrjBAA7d5zw>
    <xme:lNLZZ-z62hWgfAcE_76DJxx57O7R5duZoHb3YxNMiV85g7FWGgCvUJevg27meI4ux
    SYyXBlPVBydbGYf3Zk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeeffeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeet
    fefggfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohep
    udeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsrhhoohhnihgvseguvggsih
    grnhdrohhrghdprhgtphhtthhopehlvghithgrohesuggvsghirghnrdhorhhgpdhrtghp
    thhtohepnhhoohgulhgvshesvggrrhhthhdrlhhipdhrtghpthhtohepthhhihgvrhhrhi
    drrhgvughinhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvthgvrhhhuhgvfigv
    sehgmhigrdguvgdprhgtphhtthhopehjrghrkhhkoheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghp
    thhtohepkhgvrhhnvghlqdhtvggrmhesmhgvthgrrdgtohhmpdhrtghpthhtoheprhhmih
    hkvgihsehmvghtrgdrtghomh
X-ME-Proxy: <xmx:ldLZZ602nfxAnr7TCVrWt-BJ4tFe8u28zQB-vEdG6R0kLxofVuc2aQ>
    <xmx:ldLZZ9Ahb4CQZwjN8ndIW2_zHTKg4sYNQQB96zQ-hnvP5Re-hn2JmQ>
    <xmx:ldLZZ-gJtk-H8h2oFdn6DrUqy-g2io0AUs0UEucaGLqtVfDZ1S7bXA>
    <xmx:ldLZZxpEL1De9LD3OfkBQ3iaLqWe3DKFk4I0erQsE9UhK3FYhg-PSQ>
    <xmx:ldLZZywBs4gnlcZ2mLTXQUQqgHzrDh3s91EqqhuAPUWdT8fz4cSaXpXO>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E21222220073; Tue, 18 Mar 2025 16:07:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tce50d14c41957055
Date: Tue, 18 Mar 2025 21:07:28 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Mark Brown" <broonie@debian.org>
Cc: "Breno Leitao" <leitao@debian.org>,
 "Thierry Reding" <thierry.reding@gmail.com>,
 "Jon Hunter" <jonathanh@nvidia.com>,
 "Sowjanya Komatineni" <skomatineni@nvidia.com>,
 "Laxman Dewangan" <ldewangan@nvidia.com>, linux-tegra@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, rmikey@meta.com,
 kernel-team@meta.com, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 noodles@earth.li, "Jarkko Sakkinen" <jarkko@kernel.org>,
 "Peter Huewe" <peterhuewe@gmx.de>, jgg@ziepe.c
Message-Id: <6cf8af69-634e-40fa-af45-912540b29aac@app.fastmail.com>
In-Reply-To: <fbeca9fd-38a6-49ba-bb5f-6df5302d139d@sirena.org.uk>
References: <22ffa8f5-6590-4602-853d-ceffed580f22@sirena.org.uk>
 <20250317-solemn-debonair-sambar-f04fa7@leitao>
 <f3e47d12-f6be-4bb5-b87b-84aa0037e1ef@sirena.org.uk>
 <20250318-cuddly-translucent-teal-e2ac2d@leitao>
 <6355bbb3-a4b1-4fdc-8a97-d81bc5e1cf65@sirena.org.uk>
 <20250318-furry-piquant-orca-da28c2@leitao>
 <47c40ec0-291c-4664-a66e-d76bd6360c0d@sirena.org.uk>
 <20250318-boisterous-adorable-chowchow-cea03b@leitao>
 <20250318-psychedelic-thundering-guppy-22bba2@leitao>
 <b3da27ce-161b-4462-a608-c36f4b0696ce@app.fastmail.com>
 <fbeca9fd-38a6-49ba-bb5f-6df5302d139d@sirena.org.uk>
Subject: Re: [PATCH 1/3] spi: tegra210-quad: use device_reset_optional() instead of
 device_reset()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Mar 18, 2025, at 20:13, Mark Brown wrote:
> On Tue, Mar 18, 2025 at 08:00:05PM +0100, Arnd Bergmann wrote:
>
>> That does sound like the easiest answer: if the spi controller driver
>> knows that it needs a reset but there is no reset controller, shutting
>> itself down and removing its child devices seems like the least
>> offensive action.
>
> In that case it's probably more just refuse to probe in the first case
> without the reset controller.  Given that the device isn't working at
> all it seems like the hardware description is broken anyway...

Right, I see now that it's doing a rather silly

       if (device_reset(tqspi->dev) < 0)
               dev_warn_once(tqspi->dev, "device reset failed\n");

after which it just continues instead of propagating returning
the error from the probe function. This is also broken when
the reset controller driver has not been loaded yet and it
should do an -EPROBE_DEFER.

In case of a broken ACPI table, this would simply fail the
probe() with an error, which seems like a sensible behavior.

    Arnd


Return-Path: <linux-spi+bounces-158-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6101D80727A
	for <lists+linux-spi@lfdr.de>; Wed,  6 Dec 2023 15:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0AD01F213B0
	for <lists+linux-spi@lfdr.de>; Wed,  6 Dec 2023 14:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB912E419;
	Wed,  6 Dec 2023 14:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MeZmA6gi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D6OiCCqq"
X-Original-To: linux-spi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B16D40;
	Wed,  6 Dec 2023 06:33:28 -0800 (PST)
Date: Wed, 6 Dec 2023 15:33:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1701873207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zezMrylqGdb36QvkU2zBAFlIvARn8RpkFnyn/ed2Rnk=;
	b=MeZmA6gikd4FGvWaJR5qR+4hZjtxgZ8P9pUjTh9kDlKh28o2DXrKsiMJy3/5K+oG7xRdHO
	ek3k5WPuplKAFJ3E8gS6mS8zpLEkLgKznFfkwy/FpkrW8Ed6hoJN+zLBy+CyxiI7kZPHvi
	bP+wVy39EvjaeJF9s67gQrKAK298571q+7NjJmY4n9sxKyG9CHxXg/Es9F+xg8rx/NrqA8
	tZDXsuKACPxGuclZPAByWIsEbbhijbrUgsAbOBUUY9T2NPmXAB6J9EaNW84jtZZ3CD4Zcp
	iwZfYgPtwisjRFyA2N607phCtJdEDxGxtWA+fqWuDlUV+0KtyDvoPXg/i6w1Tw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1701873207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zezMrylqGdb36QvkU2zBAFlIvARn8RpkFnyn/ed2Rnk=;
	b=D6OiCCqqCCK70Ml7/H5hv0hyU08GdNctiY+5JgFAZHDp7tOzazsdwpOHlCpJXCKBzbfn5H
	NsAd+8yporlJAzBQ==
From: Nam Cao <namcao@linutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 daniel@zonque.org
Subject: Re: [PATCH] Revert "spi: cadence: Add SPI transfer delays"
Message-ID: <20231206153326.028a0706@namcao>
In-Reply-To: <d8eb53dc-5158-4212-8715-052e9e99768b@sirena.org.uk>
References: <20231206134446.69048-1-namcao@linutronix.de>
	<d8eb53dc-5158-4212-8715-052e9e99768b@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Dec 2023 13:55:30 +0000 Mark Brown <broonie@kernel.org> wrote:
> On Wed, Dec 06, 2023 at 02:44:46PM +0100, Nam Cao wrote:
> > This reverts commit 855a40cd8cccfbf5597adfa77f55cdc8c44b6e42.  
> 
> Please submit patches using subject lines reflecting the style for the
> subsystem, this makes it easier for people to identify relevant patches.
> Look at what existing commits in the area you're changing are doing and
> make sure your subject lines visually resemble what they're doing.
> There's no need to resubmit to fix this alone.
> 
> Please include human readable descriptions of things like commits and
> issues being discussed in e-mail in your mails, this makes them much
> easier for humans to read especially when they have no internet access.
> I do frequently catch up on my mail on flights or while otherwise
> travelling so this is even more pressing for me than just being about
> making things a bit easier to read.

Okay, will send a v2 shortly. Sorry for the inconvenience.

Best regards,
Nam


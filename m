Return-Path: <linux-spi+bounces-96-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCCA7FD910
	for <lists+linux-spi@lfdr.de>; Wed, 29 Nov 2023 15:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E14E31C20919
	for <lists+linux-spi@lfdr.de>; Wed, 29 Nov 2023 14:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8684430327;
	Wed, 29 Nov 2023 14:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I1AJlJs5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uc3Z6Can"
X-Original-To: linux-spi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C783BC;
	Wed, 29 Nov 2023 06:15:15 -0800 (PST)
Date: Wed, 29 Nov 2023 15:15:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1701267313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nvINaeel3us7q2G8aevzOOZScdLQNs5ot2M+53moFQw=;
	b=I1AJlJs5pYppHlKxHxnJgSTfOdDFkbJX8xul4rLzGgYQNn5YqZvfyAJrhfGhFJU0CFldJA
	0SZurWoK/YNvzfnPPSeiVcKKpjoGOVo8vhmeyk5HVrTS4r6Iq4tk9JzzxlYjA++qmcrUpp
	RT1dqHk0uMqEmcEyyrkJPluA3IRdw1CpTmXUx0jPWw9ODWmM6JIv0P6se8I89xrVEDohf+
	AOZIAfSaXpFFT+QIENgJanphEnsYqv9S0FGiGWy2cGH+UaQoFvMj9wWaL3750t8uDlDRl4
	1u/tjeEFBevfLZDxv2Cy/k/RiL9XdTtA0ppl7aiyqdHM1LcJW0ltpJHLVfS0rw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1701267313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nvINaeel3us7q2G8aevzOOZScdLQNs5ot2M+53moFQw=;
	b=uc3Z6Can7SdrJXV08lkocsrKGPRby5hRaK/0tEO3E9BRnD2CAhdQEXi8q3hy9c7YZSwcew
	zzIva1xfW2VnV8Dg==
From: Nam Cao <namcao@linutronix.de>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: broonie@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] spi: introduce SPI_TRANS_FAIL_IO for error reporting
Message-ID: <20231129141432.ZzaLYucz@linutronix.de>
References: <cover.1701264413.git.namcao@linutronix.de>
 <361901574eec1271c0969edba6492d3f2132fade.1701264413.git.namcao@linutronix.de>
 <CACRpkdZYZUP9rnXbqO1BaHe_e5R8m30sYuPmfhj=VcDS-drZjg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdZYZUP9rnXbqO1BaHe_e5R8m30sYuPmfhj=VcDS-drZjg@mail.gmail.com>

On Wed, Nov 29, 2023 at 02:55:18PM +0100, Linus Walleij wrote:
> On Wed, Nov 29, 2023 at 2:32 PM Nam Cao <namcao@linutronix.de> wrote:
> >  #define SPI_TRANS_FAIL_NO_START        BIT(0)
> > +#define SPI_TRANS_FAIL_IO      BIT(1)
> 
> Is it obvious from context when these flags get set?
> from transfer_one() and in which flag field?
> 
> Otherwise maybe we should add a comment.

Agree that the purpose of this flag is not clear. I will add some
description in v2.

Best regards,
Nam


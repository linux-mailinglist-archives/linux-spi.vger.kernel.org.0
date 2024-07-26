Return-Path: <linux-spi+bounces-4015-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7D293DA7B
	for <lists+linux-spi@lfdr.de>; Sat, 27 Jul 2024 00:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF34D1C23574
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jul 2024 22:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58A914F13E;
	Fri, 26 Jul 2024 21:57:55 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5EA15ECE9;
	Fri, 26 Jul 2024 21:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722031075; cv=none; b=LyFmIqbkpUoX+WgUEz+VoQSsP8E436eA6mnrVXXEVNPuHWuTvTtn1iVCzXh0bfhdM4MTCjIwesxaGFOjfyTfZnnBG8lxvZFYbL3nk1FIi7hkVg0jnIY7l6vYG7VMv2gY/g8El1Xbj2anvBiN+7+3W6OjjB56sb+ODf8VDL+FRf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722031075; c=relaxed/simple;
	bh=zevQQeRXcnjmHCJttKx3+d/mw/X8OT7actM2stDnSNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ukg4+7jseAneLEgZpRa74I90EH4t3aCTyaFEu0kb4O3qpY0S39QgXzkOX42SHlU8sBJgkRqT6Bh0nNnUOkmhBzprgNerlovxIKtzbDa7KuyVcYJAQT5Iu2sM12PjU1YlS1pNv0YKLyNdTuwp47hAYnHDVJd+mdiHJe3pi/9nwR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e860cde.versanet.de ([94.134.12.222] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sXSwg-0006AP-9o; Fri, 26 Jul 2024 23:57:50 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Fabio Estevam <festevam@gmail.com>, Conor Dooley <conor@kernel.org>
Cc: broonie@kernel.org, linux-spi@vger.kernel.org,
 otavio.salvador@ossystems.com.br, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject:
 Re: [PATCH v2 1/3] dt-bindings: trivial-devices: Document elgin,jg10309-01
Date: Fri, 26 Jul 2024 23:57:49 +0200
Message-ID: <28702815.czjnFlTdjD@diego>
In-Reply-To: <20240719-unquote-query-a76fd9487bf9@spud>
References:
 <20240719111210.1287783-1-festevam@gmail.com>
 <20240719-unquote-query-a76fd9487bf9@spud>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Freitag, 19. Juli 2024, 16:45:24 CEST schrieb Conor Dooley:
> On Fri, Jul 19, 2024 at 08:12:08AM -0300, Fabio Estevam wrote:
> > The rv1108-elgin-r1 board has an LCD controlled via SPI in userspace.
> > The marking on the LCD is JG10309-01.
> > 
> > Add an entry for the "elgin,jg10309-01" compatible string.
> > 
> > Signed-off-by: Fabio Estevam <festevam@gmail.com>
> 
> Please send cover letter for patch series. The whole lot seems fine,
> although ideally this wouldn't be in trivial devices - but I think the
> series is an improvement on lying about what's on the board ;)
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

with the error Rob's bot reported about the usage of spi-cpol and
spi-cpha, it really looks like the bindings needs to be more fleshed out.





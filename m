Return-Path: <linux-spi+bounces-6203-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 773A59FE3DE
	for <lists+linux-spi@lfdr.de>; Mon, 30 Dec 2024 09:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C72443A1FAA
	for <lists+linux-spi@lfdr.de>; Mon, 30 Dec 2024 08:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4898A1A0B0E;
	Mon, 30 Dec 2024 08:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="V2WVMabC"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EAF25948E;
	Mon, 30 Dec 2024 08:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735548419; cv=none; b=J1nrSb8VB+8qctcckUI0mYahzU/Es3+KW5yJTBBp2KAqvu7Dr9dTG378ZSzFFiz56nz6849lSfREOmmuRZeodq7yzVQt5jk6gOS9uO0r97fOF/alKzu04ZFStzInVnZjAtbfkq/qnjpoMaRIbHXT8i1Q8wmhRw8UMUlWh3Ct6Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735548419; c=relaxed/simple;
	bh=5qCsLO7/DPq0fAwnmdxvog17EUVkdcDvufsuKKDDU44=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HUPVlPdka+b6H/G8tTctmNiBKt3PnVbB6I7nIkOkN0pmStxYssDthEMyWSSw90YQClHTDnVfZWFCWknnSB02bE2jxj6rUfB2dh6U+97lcWWNndVkjkxkG/PFF4DM449V2D1THsAVWGXrUi2FVs47rpKd12x62gx7h/6xEI6z9PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=V2WVMabC; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1E2C11C0006;
	Mon, 30 Dec 2024 08:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1735548414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5qCsLO7/DPq0fAwnmdxvog17EUVkdcDvufsuKKDDU44=;
	b=V2WVMabCR3tv3DYkj8ceVupPJhyavl3qhgOPs/I9FnR1jKneit/XiPGS4Oc3CUJ4NxgIDa
	pLsgJlKUNCJfA515f2cbXKr4alkKR+evB+Nhem5PI6cI4VnnEOcC/HAK8JCJ1JdAfzJmTe
	6dgsWTL9OpD5zUqe/8e95WW3QQ4Tp+4lMXZeQE2S90e4/GkcOWocy7y7wQ5JbxsZYJxu3k
	9l1OiSjR1bbhRB8hcCLOCEgC5RZ0vKiojIFwD8vKUgqnyFwFYK6QTPAFa7ivLgOObUwIZw
	2bJ9jpIfno95cevOBvtX5QOOsUSJQh9z8xuE9lsVYdYaV2AwFpnAnxqv/vl/Qg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Raphael Gallais-Pou <rgallaispou@gmail.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>,  Thinh Nguyen
 <Thinh.Nguyen@synopsys.com>,  Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  Adrian Hunter <adrian.hunter@intel.com>,
  Ulf Hansson <ulf.hansson@linaro.org>,  Richard Weinberger
 <richard@nod.at>,  Vignesh Raghavendra <vigneshr@ti.com>,  Damien Le Moal
 <dlemoal@kernel.org>,  Niklas Cassel <cassel@kernel.org>,  Alexandre
 Torgue <alexandre.torgue@foss.st.com>,  Jose Abreu <joabreu@synopsys.com>,
  Andrew Lunn <andrew+netdev@lunn.ch>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Maxime
 Coquelin <mcoquelin.stm32@gmail.com>,  Mark Brown <broonie@kernel.org>,
  linux-arm-kernel@lists.infradead.org,  linux-usb@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-mmc@vger.kernel.org,
  linux-mtd@lists.infradead.org,  linux-ide@vger.kernel.org,
  netdev@vger.kernel.org,  linux-stm32@st-md-mailman.stormreply.com,
  linux-spi@vger.kernel.org
Subject: Re: [PATCH 3/6] mtd: st_spi_fsm: Switch from CONFIG_PM_SLEEP guards
 to pm_sleep_ptr()
In-Reply-To: <20241229-update_pm_macro-v1-3-c7d4c4856336@gmail.com> (Raphael
	Gallais-Pou's message of "Sun, 29 Dec 2024 00:32:42 +0100")
References: <20241229-update_pm_macro-v1-0-c7d4c4856336@gmail.com>
	<20241229-update_pm_macro-v1-3-c7d4c4856336@gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 30 Dec 2024 09:46:52 +0100
Message-ID: <877c7ha77n.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hello Raphael,

On 29/12/2024 at 00:32:42 +01, Raphael Gallais-Pou <rgallaispou@gmail.com> =
wrote:

> Letting the compiler remove these functions when the kernel is built
> without CONFIG_PM_SLEEP support is simpler and less error prone than the
> use of #ifdef based kernel configuration guards.

If that does not lead to any warning, I'm fine. However this kind of
change is better received subsystem-wide than platform-wide, if you ever
wish to go this route.

> Link: https://lore.kernel.org/all/20240716180010.126987-1-rgallaispou@gma=
il.com

This link however seems irrelevant.

> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>

Thanks,
Miqu=C3=A8l


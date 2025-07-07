Return-Path: <linux-spi+bounces-9067-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E41F4AFB64B
	for <lists+linux-spi@lfdr.de>; Mon,  7 Jul 2025 16:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8314189BFC7
	for <lists+linux-spi@lfdr.de>; Mon,  7 Jul 2025 14:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA6A2D8373;
	Mon,  7 Jul 2025 14:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hW7AEn/k"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3314D81724;
	Mon,  7 Jul 2025 14:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751899422; cv=none; b=rqYh/f9TP2ok1lmQNXNaqGiGEggjH9O+OSIfsNUxKJ8l94ES7+9S8b/5aLBspaMBR8wN/qrOs6SNFkn4bAew4jojqK+CRXy52y1ZnqJe6UQQ77XTo2Ssjk/1IB/KJRrWc9Qkq48mMoiQadly1RJVqWq3Pnv6AT2bODZPQIKyWUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751899422; c=relaxed/simple;
	bh=pygmB6Y0A8GnIvfkKxpvuMj1/8T5+x16Brq+Mu3flTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d7Zf+Lw/JYp47Efp0Wg6ieQgakyoACzZud1gnoOtrLav+lVmcmszxPOtAEfLf5S3SHmbeqUV0IBQZtupbzRhcGGEMI0/s4pTSAL3+AtjIHO7KxmaDflAf0qJOnWsxs35Q5OD8VewOZBzfP8yRys6TqG2Ppsd9ueKgRFZIWU0UYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hW7AEn/k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4AD9C4CEF4;
	Mon,  7 Jul 2025 14:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751899421;
	bh=pygmB6Y0A8GnIvfkKxpvuMj1/8T5+x16Brq+Mu3flTM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hW7AEn/kJoZ8G/Ci6vwPyUhco7+VT+w71XTx1ckOOlEvFJ/XKwDhl5sE5b9n0vETn
	 EoBQn8bKGxm2xp53PmFWiarQqh3pag3ilMqvwhTHb3byIy+pYBNJSt52ADXNa/MOFS
	 +St49nQkrtc6KQHchPzRFYKXHZIdwRyz1ELm99WFwf2g00rsR9i0S6bgj0rpxYxHuL
	 5PigZFIt0Es2ZgJV0o8sqXtLuX+r7gcko2jCPn8vGe4Lng1QsjwOuSMZLDyMrFf0Wc
	 IFOnWDqHkuLn04u1NoOC2CQOYtSHxEo9oBSMWBRjdi6oZ3bQwILTM5qDqUhwWEOJ8M
	 QHRiEECr41zTQ==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ae0de0c03e9so550485866b.2;
        Mon, 07 Jul 2025 07:43:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUx2CsW5Dj3VM8kkvB0clcusEKyVO/CJ8U11NYjQD9c4CBoaTQGrmLEZO+sDuqP5ongqreafLtY8hVFbtc=@vger.kernel.org, AJvYcCX9yhULsz75g4zM/PAUvnYuNLtyMqxVgz+NQvTwPmDjmI91azrVqdTOsoTUTYV9ESCC1h7cG8eL2SJo@vger.kernel.org
X-Gm-Message-State: AOJu0YwmyAqj7gg3J0TOUCJ0Jgw7d6XT7bLie5vVQN+y/jwr9041R5UL
	si61oRL9LJHa3vXi/UkwjWWQ4KblF7r5Ps7LT9cpFTzIYTs//bx2HEfvs5WfWQr677sMf00s0bF
	ZZow5k+Sn+upXg/dg1QAzmWFI477ocw==
X-Google-Smtp-Source: AGHT+IH+f8zvdudHp1LuRKAAn7cL9u6+1JqOnozuxrIIQH8whQPjPMtiGupPBrID+yAocJ3AfWvuowkyHK1U/F/njY4=
X-Received: by 2002:a17:907:96ac:b0:ae6:abe9:8cbc with SMTP id
 a640c23a62f3a-ae6abe98e66mr63239166b.12.1751899420274; Mon, 07 Jul 2025
 07:43:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703183537.2075746-1-robh@kernel.org> <1e33e6b6-845a-44bf-a398-4a9fb895a125@sirena.org.uk>
In-Reply-To: <1e33e6b6-845a-44bf-a398-4a9fb895a125@sirena.org.uk>
From: Rob Herring <robh@kernel.org>
Date: Mon, 7 Jul 2025 09:43:27 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+8ObyEM-f88QSq1QfptVPrk5s5mVM-irq4ZTGNW9NKTw@mail.gmail.com>
X-Gm-Features: Ac12FXwY1NqOYzEWnEAy2ESIy7UgECjX4aJqnXTz286AyGb5Rk-mUEzeguxMrTU
Message-ID: <CAL_Jsq+8ObyEM-f88QSq1QfptVPrk5s5mVM-irq4ZTGNW9NKTw@mail.gmail.com>
Subject: Re: [PATCH] spi: stm32-ospi: Use of_reserved_mem_region_to_resource()
 for "memory-region"
To: Mark Brown <broonie@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-spi@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 4, 2025 at 8:50=E2=80=AFAM Mark Brown <broonie@kernel.org> wrot=
e:
>
> On Thu, Jul 03, 2025 at 01:35:37PM -0500, Rob Herring (Arm) wrote:
> > Use the newly added of_reserved_mem_region_to_resource() function to
> > handle "memory-region" properties.
>
> This breaks an allmodconfig build:
>
> /build/stage/linux/drivers/spi/spi-stm32-ospi.c:775:23: error: unused var=
iable 'rmem' [-Werror,-Wunused-variable]
>   775 |         struct reserved_mem *rmem =3D NULL;
>       |                              ^~~~
> /build/stage/linux/drivers/spi/spi-stm32-ospi.c:776:22: error: unused var=
iable 'node' [-Werror,-Wunused-variable]
>   776 |         struct device_node *node;
>       |                             ^~~~

Sigh. I swear I had fixed that...


Rob


Return-Path: <linux-spi+bounces-2304-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD7C8A1384
	for <lists+linux-spi@lfdr.de>; Thu, 11 Apr 2024 13:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52B971F21973
	for <lists+linux-spi@lfdr.de>; Thu, 11 Apr 2024 11:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251BD14C5AF;
	Thu, 11 Apr 2024 11:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7NAwlJZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5094B14A084;
	Thu, 11 Apr 2024 11:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712836019; cv=none; b=jsZ8G1bhvBr9ilythOEdhjsKzUk3zQuWHcEjlCJ0vA5pROgR3k7EuxwiZHKFIJcDT1/MsH5igaxY7zyUqea0Q/DafVI6O51CdRdsueV2EGnO28/Y21eexprGA/BWbtlO7Np8sOdj8uoIXUelE75g4Ln9x63B6jXN19aECksYSk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712836019; c=relaxed/simple;
	bh=KjhntZT4X/nTqWQsZFRH5PaQagH/ru6ZJP4J3uC+CMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bZQllyPpRZavkOMX+2qIlgDLjoFV90jSLcTBCoBmm0l7V2klg0rV1FZ92WCkNe0eRuxN9QkU/M6bnYVdi5bIR+/n6jynfDXcuqyhjNFBqLVq1U9EJyjKtJJS6UtFSNl0rHbbSIDbuL5UmNw/3CLvNTnCfZmVg2cJxfGRZy8cpEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g7NAwlJZ; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a51c8274403so612099766b.1;
        Thu, 11 Apr 2024 04:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712836015; x=1713440815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KjhntZT4X/nTqWQsZFRH5PaQagH/ru6ZJP4J3uC+CMc=;
        b=g7NAwlJZjSJm65BbXkx2HWy3awX8A6hcdh1hSXmtTSy3UgreV0qOwlwZkM8p7j3oVD
         sABPWxmlbTbIz9/uxIgj4/CrFrHysiKzxVZAFN3l9W9lwtjaWukQM+1WpNex+Igc0WSw
         6EyTWAI3ShCqDlB1i87ZgCKj7ymnqf5NQv0Y2gITEPqoUjpEVipJKMSkgjoL8m5RJgpX
         eSguo5TltPvxAcORsttjklf30tpNaaa59DBcEgqyeOt09nLKyOH7giGTM3t6FhnBeBL/
         RO3Ef7k9pci7x29zc9XwtU/bVe+T0/pw/iwYwtsQdl2hHFXqGmA2ysdBQ/o4uZVfeiTs
         VkIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712836015; x=1713440815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KjhntZT4X/nTqWQsZFRH5PaQagH/ru6ZJP4J3uC+CMc=;
        b=s68UzSUetD4mHM2Nmy4VtADRSRJztwqoyt6fDxnrpuZud1+/N5BECodKioWVKqzdX0
         Kgx4YAviXB5gYC2SNlQrH/UqZyW70sI93DoOlMuDDsTGMg1ZswUmGiIzNCAsIs2THmbk
         eDZxllLq5t4wY2+92m9fATOFI2lgy/EufEsp64TEGok+mqiIwTE2dI5ulr8TZkDj2BV4
         k2/gqzT1l5AFmtHtIDY1lmlJpwFF6mzNZxlRok8ayHyvrJDqpYQlFJntgPdt3pOVPb4V
         b5KzcVJkIM5BwHmXVif8d2G9XWi1YR3Sy75ZvaBXkiU4m/ViVtCgdTBchrty22RhvCcx
         Q7vg==
X-Forwarded-Encrypted: i=1; AJvYcCUKSRNuavlKgyTK/Yk4/CiKU7+dWSdeT8AtpRR4cAlZzDb7qjqMfu/LPzUO/3r5F9E+XBjSiekpvmLMD06gfOb9Ay6ut0jgSSDgr2N22bZPArpnytphE8LqPMJ8BlrGyHHhJdR76A==
X-Gm-Message-State: AOJu0YyrOGqrZZubrXhuXqSaotEXMNLdRZ9GOfIms6ojb8kJrXsPLcIu
	KCcsyfqPXKOI9izgjx3JTI0Y5i7dR0M5OlvvcIgjE/XV6rBFYRu2UIjTf0dxY+igRZaLN9Wjb5V
	CtGebhxA+ifuFrwIfUi2ySfAXtQk=
X-Google-Smtp-Source: AGHT+IHLDNhprJJI6WkJ7buHlQ7mGTMiPo9+OJ4PsbdNlNqJqfUaHgGsvPNwkQIcYxuTDgQ9TOrwRLGulloAdl0HI48=
X-Received: by 2002:a17:907:94c1:b0:a52:15c3:b64f with SMTP id
 dn1-20020a17090794c100b00a5215c3b64fmr2855811ejc.4.1712836015390; Thu, 11 Apr
 2024 04:46:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411090628.2436389-1-ckeepax@opensource.cirrus.com>
In-Reply-To: <20240411090628.2436389-1-ckeepax@opensource.cirrus.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 11 Apr 2024 14:46:18 +0300
Message-ID: <CAHp75VeVpARChV6mkFfVKqHkOgQfoUdGpAZQ5M6Y9YRK1eKnQw@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add bridged amplifiers to cs42l43
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: broonie@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl, 
	bard.liao@intel.com, linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org, 
	patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 12:06=E2=80=AFPM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
>
> On some cs42l43 systems a couple of cs35l56 amplifiers are attached
> to the cs42l43's SPI and I2S. On Windows the cs42l43 is controlled
> by a SDCA class driver and these two amplifiers are controlled by
> firmware running on the cs42l43. However, under Linux the decision
> was made to interact with the cs42l43 directly, affording the user
> greater control over the audio system. However, this has resulted
> in an issue where these two bridged cs35l56 amplifiers are not
> populated in ACPI and must be added manually. There is at least an
> SDCA extension unit DT entry we can key off.
>
> The process of adding this is handled using a software node, firstly the
> ability to add native chip selects to software nodes must be added.
> Secondly, an additional flag for naming the SPI devices is added this
> allows the machine driver to key to the correct amplifier. Then finally,
> the cs42l43 SPI driver adds the two amplifiers directly onto its SPI
> bus.
>
> An additional series will follow soon to add the audio machine driver
> parts (in the sof-sdw driver), however that is fairly orthogonal to
> this part of the process, getting the actual amplifiers registered.

Quick note: I dunno how you prepared your series, but the cover letter
missed the versioning. `git format-patch -v<N> ...` does it correctly,
where <X> is the version number. You may also see how I do with a
script [1].

[1]: https://github.com/andy-shev/home-bin-tools/blob/master/ge2maintainer.=
sh

--=20
With Best Regards,
Andy Shevchenko


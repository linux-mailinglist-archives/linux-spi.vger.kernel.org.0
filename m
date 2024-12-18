Return-Path: <linux-spi+bounces-6115-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F759F6DD6
	for <lists+linux-spi@lfdr.de>; Wed, 18 Dec 2024 20:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8350E168A8B
	for <lists+linux-spi@lfdr.de>; Wed, 18 Dec 2024 19:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478DB1FAC40;
	Wed, 18 Dec 2024 19:11:14 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0094B1FBEAA
	for <linux-spi@vger.kernel.org>; Wed, 18 Dec 2024 19:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734549074; cv=none; b=Wq30b/zdbXkM/cyh28ewe7rwa0GLgl1cDmEKuM8omvoqR8SKHhktAnUFsMTrkScNpGrqsJemQyY6rKPmFx7qX28nOQLttAEMU66mwBgu1czt8lX3Dxyye0P7gCRCALF0abFvc5eiJ4dnqBYk+tQSPU/NSb0bwcOqhGj6Sx8FiLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734549074; c=relaxed/simple;
	bh=o8WmGY4A48l9tahSU4Wv0C45hmWVp4/CZf13nXfIEMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y544ZHaK7N785sIkhXXQ11ALMdONba4iwFMOSp6hBy14ip5CyE30JjW/zQH7xTAPUolVPql6EdTxc3ccEQr+WJ9CzcLs68pBcgv0jp4w4VpdgBf8mx3ul64Xdv/r1CcT3jZvRniRZWReqodrQtRTgSrmqYeuMcEXIMF4SlbyyI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6d8adbda583so222566d6.0
        for <linux-spi@vger.kernel.org>; Wed, 18 Dec 2024 11:11:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734549070; x=1735153870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2tMeJYQga0hhnHEwekycDFOydstP9TVFTuQ8Wwc6BFo=;
        b=rJ3hfVfu4idiAFrS8VXPnGA9/aKhm8uMlCfZDB8No9C5IjSyIWJR9G9eGv78BvaY8l
         I92MzlG7Rth+BzWeWBHvR6dxXBNPn1BqVtqaB2/llaBKZD7XN33ov92k6sVoYErpy14a
         hB928BLhCYx1XqlBE9uuOFvvxOPMM4gbpFVkyhr7KIiz73Lx68/afYmRavOGstmq6+Ip
         wGRBjNbHcmS8S+Dv45eP1UnT3u7VDVLiXKiwNFlNKw0pizWT99yjjvxAneo+BQxVC3cu
         vIdzmona8ls9tl2wkVVWWyzoqSV5jid4jF5CRiKj1sIqnX10u47a0LhMp7AM1F/3FO7+
         UlTg==
X-Forwarded-Encrypted: i=1; AJvYcCXEWOnNASj7H9r2hImbcSKK93i5fZ/tC01/0A8HaBwCkRZ9fRnMB6sSflKU/1FUidlVnDWp2NlX9To=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3kIg7d816Ou9z8ito+HK2qXXr44VfzIuaMkGd6rOJUoQFbIpY
	tJjo4ZVL4LWAqYPrZgtmbQVPT4Y5iSY/AH6lYx/ONwVeAFJWz8r8CWhl9t9B
X-Gm-Gg: ASbGnctpcR/jT/Od3z+D+Z08otKSrHwETzrLV0+EjxfLl5dWQLdACM7yXYuEId2/4NG
	29lOfor07R0i0rKnFivJRbwXCUKqNmEtLfyNnjzyjo9qOO5xywz16heRSxnLwfqu6WlI3Rs8zTY
	GkULcniKRdOf39ERYsWtyedMqO7VSF3TwRcCC+oQtnhwetJ85yBAjNIJGXXfIWWwZOZ70DSNEl6
	Wowb/uTlSldqvGXKH0egaw4DdmFgqpcywlwdrZ3JTCnB+92HMKlglnsnLqhDPO0yJedZCnaJmsG
	eQnloDsQLPeASUeNV4vQAmA=
X-Google-Smtp-Source: AGHT+IG21PLFB/5rZYjoct/mR0DIc81pTmK9Jp78BDxrFRgYZJ63/42c62FR//9OeIEQSjLtIrkZ1A==
X-Received: by 2002:ad4:5d41:0:b0:6d4:1ea3:981d with SMTP id 6a1803df08f44-6dd14c9d169mr13232496d6.43.1734549069922;
        Wed, 18 Dec 2024 11:11:09 -0800 (PST)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com. [209.85.222.177])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dccd26c8cbsm52981916d6.54.2024.12.18.11.11.09
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2024 11:11:09 -0800 (PST)
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7b6ed9ed5b9so773080885a.2
        for <linux-spi@vger.kernel.org>; Wed, 18 Dec 2024 11:11:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUndvHX8CYyYbx0kWBwT0G1VvDJvDQyy8/TnnouBHPctd7M1aUhRKb77X60ZmJlHCzjcDO0krF2sgw=@vger.kernel.org
X-Received: by 2002:a05:620a:2607:b0:7b6:6a3b:53af with SMTP id
 af79cd13be357-7b9aa8d5070mr95716985a.14.1734549069081; Wed, 18 Dec 2024
 11:11:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217114226.1223724-2-u.kleine-koenig@baylibre.com>
 <CAMuHMdVzyq6L+9iNhtSdGpAJOKyu2vkzvveHXt0in9xUhD6mLQ@mail.gmail.com>
 <tk6wlbylk7aqfd3sys2jitpnbdz4xomdg2yr7hsppxyptgbek5@3vtvajq7krun> <CAMuHMdU0FjXBgFLUxxvQeODPsU8xf+LAdQCg4xpAn_omJeA9WQ@mail.gmail.com>
In-Reply-To: <CAMuHMdU0FjXBgFLUxxvQeODPsU8xf+LAdQCg4xpAn_omJeA9WQ@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 18 Dec 2024 20:10:57 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUEXFFXt1EkGafv+-arG4x4hFQMGO6E14O7zguyGT0kmQ@mail.gmail.com>
Message-ID: <CAMuHMdUEXFFXt1EkGafv+-arG4x4hFQMGO6E14O7zguyGT0kmQ@mail.gmail.com>
Subject: Re: [PATCH] spi: spidev: Align ordering of spidev_spi_ids[] and spidev_dt_ids[]
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 8:02=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
> Further improvements could be:
>   - Generate spidev_spi_ids[] from spidev_dt_ids[] at runtime
>     during module_init() (consumes cycles :-(,
>   - Teach the subsystem matching code to strip the vendor prefix,
>     to get rid of spidev_spi_ids[].

Oops, and modutils, as the tables are used by userspace :-(

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds


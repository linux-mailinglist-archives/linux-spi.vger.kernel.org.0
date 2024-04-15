Return-Path: <linux-spi+bounces-2349-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9972F8A5716
	for <lists+linux-spi@lfdr.de>; Mon, 15 Apr 2024 18:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 534B9282586
	for <lists+linux-spi@lfdr.de>; Mon, 15 Apr 2024 16:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DD77BAF9;
	Mon, 15 Apr 2024 16:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgS4K1CH"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B3F7F7DD;
	Mon, 15 Apr 2024 16:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713197258; cv=none; b=Ul116LyunrH4enE+JJqserj2pgP3QtB2zfeXMlUweZjxEVSadUvEpeBy+068vu/bF/T4affmjpEucr1Ln2TXvakc5YnxKURyHT2j2K14UV0kfam+PHkTwDOxQTrlmAwtBJymlFb76prirK+kJTaYFB1i932LhHUgLDrd6X/UhJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713197258; c=relaxed/simple;
	bh=9UiRZsbt+NcBd+TU5C5uMUSwnFOLdOyBJsHaWX4gY8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QCA1DY4YPpb5rGm4o/zSeqxmrTnIaPtTj1FJi6a9Fz7sFan17kRkqxz628LxGJ4EKzmq6SDXB19woqw8OMrMxry96cntoAp7Lihh1Z17KFC/fMFCHnKW+qVyfyKlkTJ2BTN65y2myMOgQtRtoc8tbAF8d5H+3fOGlpbLQfDgPvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XgS4K1CH; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a51ddc783e3so415619666b.0;
        Mon, 15 Apr 2024 09:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713197252; x=1713802052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9UiRZsbt+NcBd+TU5C5uMUSwnFOLdOyBJsHaWX4gY8A=;
        b=XgS4K1CHTegAaaK8hJbzLKFndBdcrCVR8jNBd1IDSwkvODNzN901mD0/L5m7SFkaPC
         gwDPPOkMnlJpFhxjtsCNVyqyTHtF7fQcXct2IgLYh/7R/6fT1Rfvohis8/p3PZpqdYzK
         hqKXAaz/drt+YjU8GpTRNhcJFZmgTo4BEVtfR7F+kCe0997LQ2zLxVZP5NYkhzFFurBF
         CiB4WFBB6Qq2XlfKeqMFWv0wBVmSc8oYkcSihgmq9t7DGmVLqBftRhhS/hiSkwk9DZ1D
         SaGlmYYzD51NhS48vXV3x507fXtN5yhYYsU25v2Ncnh7mx9qRPfZF2YRg5PSOk25ocfY
         YuIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713197252; x=1713802052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9UiRZsbt+NcBd+TU5C5uMUSwnFOLdOyBJsHaWX4gY8A=;
        b=pqu5Iv2LOWKNVKQQZB7L7Mhqo77QYirhA/xxkpCKrDuquoFx8rfHhM9arUFienMBG1
         5wQglrNcoR26NWeAta7XEzImTaiEqa3R2QS2bAHPoCwwvPfihTrUpZZ1tctWEOTQa9dp
         tOd38WsPAJXLgoqhz1kW2sbuBNClL3bo2kbxATzuPyz2+TOub22PODMIEoUyecuccAet
         R5aTXG4oUC2oEYSEzwhdo2Svh6rrwZ+aaXYgo2LGNPHLzsptTsitzjW1wzy5FT5pJgYQ
         KjYoB7GRCa0/DDDEc34FjtpfXeHOItITXObHoHKNddoVFrw443cONeukGGHe3nhUJEWI
         YLtg==
X-Forwarded-Encrypted: i=1; AJvYcCXN1KQueVkm0/y+Ki8AH4G/qopkQlTFRbuYHMi4mBUelwZsv6oPKHF3xCYzU0UQcF7ZFKBItFdHkhtvAgSXx6RHGH+weuONMZPvFLBgQIvLKWE4/SL5JysCbab5//LdLV1k1ivmgw==
X-Gm-Message-State: AOJu0YzNrQod5JLdFc7LKxVUI3i0x2n9C17plcDPEWWGrYvWR7UZcOz0
	+j2qq3ZxlM/jkN7+NuUDgAoC5ZGfF7ZtuoVtWZqBlZcrUjPO2CMwYJkME2Miuhu7lm8Hgv4a9Hh
	PHNBLnBVQBHsOiSnm6Vysxf42V+c=
X-Google-Smtp-Source: AGHT+IHuRtVgEM8ralj4AFUQLM9fC0qv3StvDyIRMMIk+Aa33FyWMcsoM5iYcxnvsNHCr0BbkYesMwj4dIHk8IQ4694=
X-Received: by 2002:a17:906:b0c2:b0:a51:bc68:d61e with SMTP id
 bk2-20020a170906b0c200b00a51bc68d61emr6538049ejb.30.1713197252611; Mon, 15
 Apr 2024 09:07:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415140925.3518990-1-ckeepax@opensource.cirrus.com> <20240415140925.3518990-3-ckeepax@opensource.cirrus.com>
In-Reply-To: <20240415140925.3518990-3-ckeepax@opensource.cirrus.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 15 Apr 2024 19:06:56 +0300
Message-ID: <CAHp75VdGq8L5ZQxo0BrC-TevY+pP2s0ZYkHcefjROvpf1+5MNw@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] spi: Switch to using is_acpi_device_node() in spi_dev_set_name()
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: broonie@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl, 
	bard.liao@intel.com, linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org, 
	patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 5:09=E2=80=AFPM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
>
> Use is_acpi_device_node() rather than checking ACPI_COMPANION(), such
> that when checking for other types of firmware node the code can

a firmware node

> consistently do checks against the fwnode.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

--=20
With Best Regards,
Andy Shevchenko


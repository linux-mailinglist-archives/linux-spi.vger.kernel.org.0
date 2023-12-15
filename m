Return-Path: <linux-spi+bounces-300-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D834B8147B9
	for <lists+linux-spi@lfdr.de>; Fri, 15 Dec 2023 13:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4A9FB221E8
	for <lists+linux-spi@lfdr.de>; Fri, 15 Dec 2023 12:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381BC2575D;
	Fri, 15 Dec 2023 12:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oi+Fsykk"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEB22D021
	for <linux-spi@vger.kernel.org>; Fri, 15 Dec 2023 12:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5cd81e76164so4960517b3.1
        for <linux-spi@vger.kernel.org>; Fri, 15 Dec 2023 04:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702642274; x=1703247074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8LlaW71AKNIHVf5i4MpBNEk/CoxwYJFC465LPVsr3rs=;
        b=Oi+Fsykko2bdKVGvyLxGAatl27GLO9Up+yyceCNTfo90+dWmy+ShqV4639RCgVHB7D
         Ef9aEQjiy4l3DgtxsRGhIS4b4sshvDiExn1wDb3E3Mkhm8q4R978GXQ4LrAsI9ODGzcP
         oP88Hu58CiKV9KCiLXrg/bORad7Vn91zeZJ4zNy6zrtUf+JrAXmW2Ir6zLZZYshfHxHf
         UTOgm+lCpitg8z3rCKg1QmG9VaD5ULzJ45E015WkHSP6dR3Q49vNqLgExaMg1jfrpyGP
         p6xyYQ/Rav37xKeAiplSpWnVXiG318MHtas0aFGYwcdhwbDgI/EjSVlZJk2BBfiLFdUr
         ifHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702642274; x=1703247074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8LlaW71AKNIHVf5i4MpBNEk/CoxwYJFC465LPVsr3rs=;
        b=TQ4HXZGZijUY16fJzR0/rOnTQToJ3jQy4aoWVPACRXtqR2nRcY9IQNqec1ERBGjW2e
         pvLYSuDCrwtkpIGCcxTxAgBK3/szGtxRo8wcWyOiU7BgTpwHq08v71gMRx2lttCHzm9b
         7NcfXbTNWghcNFszdCcqA91kyA7CVcg5yr8m+zZh085C/wwhTzP8qlmqVXIu7l75VCdT
         kaW3aJjJXw2RgAHMMTCEtxqxwupI68D3mIP1+zOXRZvqX/xqxyTeVgDe6QNGjSYhaVsw
         bNct8p6kv8XysvoenjM2arBwoZRiqwt2t+YnDr/l+7Jqqv3lNAKvfi2NrIGYipADt+YD
         dvNQ==
X-Gm-Message-State: AOJu0YwNUyDEk3hvom9UFi7YoJLrnK3WZgHX9bDLwmKtOPJRBGNhTqgi
	IP0FKrnMVO2ZEeFE3Fpm3dRkHS9sGzH6bliY3qKoHA==
X-Google-Smtp-Source: AGHT+IEHu2IWAaWxxHUEHVSxe/DRzpSwUtXngirkdKnPai/DvrVURC/4cl8V5UCbsgzDTEEOBvJK4a5VBAy59nROWeU=
X-Received: by 2002:a81:5b85:0:b0:5d7:3f4d:2e2f with SMTP id
 p127-20020a815b85000000b005d73f4d2e2fmr9923512ywb.14.1702642273812; Fri, 15
 Dec 2023 04:11:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f06a9b6eac184cc648ae7444c480add6da87a84d.1702639801.git.namcao@linutronix.de>
 <4036d8d5845c04179f330f83e825a3921aa50c5a.1702639801.git.namcao@linutronix.de>
In-Reply-To: <4036d8d5845c04179f330f83e825a3921aa50c5a.1702639801.git.namcao@linutronix.de>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 15 Dec 2023 13:11:03 +0100
Message-ID: <CACRpkdZ2a2cHtNMuShjTvpvPQs6k7YmOE6QeB6ubEu0oGxuvLw@mail.gmail.com>
Subject: Re: [PATCH 2/2] spi: pl022: update description of internal_cs_control()
To: Nam Cao <namcao@linutronix.de>
Cc: broonie@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 12:33=E2=80=AFPM Nam Cao <namcao@linutronix.de> wro=
te:

> The arguments of internal_cs_control() was changed, but its description
> was not updated. Update the description to match the expected arguments.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202312151816.munFeE4L-lkp@i=
ntel.com/
> Signed-off-by: Nam Cao <namcao@linutronix.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij


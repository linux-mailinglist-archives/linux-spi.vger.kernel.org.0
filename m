Return-Path: <linux-spi+bounces-94-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B817FD8BC
	for <lists+linux-spi@lfdr.de>; Wed, 29 Nov 2023 14:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 256482827A5
	for <lists+linux-spi@lfdr.de>; Wed, 29 Nov 2023 13:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591791E530;
	Wed, 29 Nov 2023 13:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n9pmanAn"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD6DCA
	for <linux-spi@vger.kernel.org>; Wed, 29 Nov 2023 05:55:31 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5cfc3a48ab2so36670147b3.0
        for <linux-spi@vger.kernel.org>; Wed, 29 Nov 2023 05:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701266130; x=1701870930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xpuvInZNM8fsmU2z2sR/CbG3xzQL+n8KAjtla2xbn9g=;
        b=n9pmanAn3VcMVLpHtiz8w2WEwoGauHHU6YYMpiv+myIEONBQiYaZVIuQQkZtGMUpch
         6qPv32PnfNsYFEUOi1rg2L89Y7WvP+erDqFAmI+xV/kpaMAMVtslNHhHpTOU40unYScB
         bt/gWxK9c+GQHkpGRfjoLLpQHcXp5aFdQtDMQ81TPq4JzklpoYv6QQFh8LVwwBg9qerM
         LmSmbCCP13fjgK6B9VU9WG7P8me/qvrTNw5Zjcsx5131bB49T+P2Q3+ZJ3EPmeiyQ5zx
         6Q78sV4wfSrh6FwgJ35CYZKGFGy8Ydm3n7xTU/8mTxzVHAKSVZkCYJvzzapNfgdEeEpK
         Y5Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701266130; x=1701870930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xpuvInZNM8fsmU2z2sR/CbG3xzQL+n8KAjtla2xbn9g=;
        b=kBTzF3PxCTlMZjrtg9Q8bsn1Udpc/GH/U70YXlUA39LjmeAuOW3kN+vG6f3uBkGsze
         g7bMGgXg2BqoZ++U1Mmm1yyP6RDHza4CXl+FlBdec9Et5uYH3ZIsEnyLRAuViTC9b5CC
         77n0MnxT8qsdAeSIXOBhIlf4sn1uY79kVgVjEllZ6gJWPfDc7g+z9Dk8QqsYtkQVhaR6
         PCMxKgY3LoVKAHCUt9d1an68uhlFMtVuv73NrClj9DWz5hIThsQbHhqXFFYP6yGzdkjS
         yqLXFFe7As4Hz0mrllqCSrU8K3Dyu1BBb+dZLZsvR/sDvsuMwFMtNpU97UJ5F3rOJdHP
         q+7w==
X-Gm-Message-State: AOJu0YwraIs/mBOrjv4R2NsehdixLtXhLGm4BpWthcZXcKsP2uqBbrKV
	wA6VBNESLyapTy42lEsVsSoSo/69c1QbRm9SnbSsWg==
X-Google-Smtp-Source: AGHT+IGwu2YvBMSoYaFGrNKixDYgQXfobVbXlj1+WiRWKYV83ej5z8x/5rqafA1r99kgas/9POeBW2+CPHD4zJcuBkA=
X-Received: by 2002:a81:ac5b:0:b0:5d0:b0e7:929e with SMTP id
 z27-20020a81ac5b000000b005d0b0e7929emr8950952ywj.42.1701266130305; Wed, 29
 Nov 2023 05:55:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1701264413.git.namcao@linutronix.de> <361901574eec1271c0969edba6492d3f2132fade.1701264413.git.namcao@linutronix.de>
In-Reply-To: <361901574eec1271c0969edba6492d3f2132fade.1701264413.git.namcao@linutronix.de>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 29 Nov 2023 14:55:18 +0100
Message-ID: <CACRpkdZYZUP9rnXbqO1BaHe_e5R8m30sYuPmfhj=VcDS-drZjg@mail.gmail.com>
Subject: Re: [PATCH 1/2] spi: introduce SPI_TRANS_FAIL_IO for error reporting
To: Nam Cao <namcao@linutronix.de>
Cc: broonie@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 2:32=E2=80=AFPM Nam Cao <namcao@linutronix.de> wrot=
e:

> The default message transfer implementation - spi_transfer_one_message -
> invokes the specific device driver's transfer_one(), then waits for
> completion. However, there is no mechanism for the device driver to
> report failure in the middle of the transfer.
>
> Introduce SPI_TRANS_FAIL_IO for drivers to report transfer failure.
>
> Signed-off-by: Nam Cao <namcao@linutronix.de>

This looks useful to me
Acked-by: Linus Walleij <linus.walleij@linaro.org>

>  #define SPI_TRANS_FAIL_NO_START        BIT(0)
> +#define SPI_TRANS_FAIL_IO      BIT(1)

Is it obvious from context when these flags get set?
from transfer_one() and in which flag field?

Otherwise maybe we should add a comment.

Yours,
Linus Walleij


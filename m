Return-Path: <linux-spi+bounces-299-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F34F18147B6
	for <lists+linux-spi@lfdr.de>; Fri, 15 Dec 2023 13:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 760321F2421F
	for <lists+linux-spi@lfdr.de>; Fri, 15 Dec 2023 12:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A70B24B31;
	Fri, 15 Dec 2023 12:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KrEQCCw5"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0952D797
	for <linux-spi@vger.kernel.org>; Fri, 15 Dec 2023 12:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3b9dc3215d2so260893b6e.0
        for <linux-spi@vger.kernel.org>; Fri, 15 Dec 2023 04:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702642235; x=1703247035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rdz5g8JIsOq1Cbe3l1Dtqt4Oc9mqtgEioye8X2MmpJE=;
        b=KrEQCCw56JSgulwegh/qrVamr22TDg0oGj6oWWutKge9cphiAduVinYcAEyf1QlPtA
         QlgDBg+/pDrauOypPJKECFURVYxXeZDR5XeteFJPPN31zSKHXxwxyjfzPGiREhXKA1g4
         /LsgyP72Li1mPfgCP41PZghbbxPaStSOBX6cnmX8M0huDwSBLJcyvId9gInHVtqbDstv
         3me2eQxlPK+nPeexjEgdxqoaobPhogFQ+/o48tfcysVMGRu8NvBfDNzelq9xDFsudqZR
         xOkOAcQxcDtLzsmgOZPMlh9lXQvYUItv0P7ZsOSVo8Tjk/MOo14OaL39gvhLMVf+i7Ao
         dySw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702642235; x=1703247035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rdz5g8JIsOq1Cbe3l1Dtqt4Oc9mqtgEioye8X2MmpJE=;
        b=LwkMWCrlNSzvPmjNGYbeZebM9aRSJ5pLSPKKloC2KHlFzCxk+EzM3PHJvo4C87Nf09
         FD7iuBp2rujW84JM6FCP/io1MbFh9Tlw2hArftV8f43BV6XL+vXFi9/PAcHH57WW7NZJ
         RoZsEcM38DNUfZp8SRloOk7utyOLrkpaxvAHdOJPxBWrSk42OGX0bNpfaPUNMTdXZAbg
         V90WCcEQQZGZpujhScPNVzOVeuEPUP9+XICYNpbqNW+p35pjcL9q3n4RaSM0PXxAMFx0
         DekPZ3xdFgMXZ3imjFsCNffWd23udDmn9BultiDPReiYWfbHykv/5A2yQYY04QY1rvAn
         JPTQ==
X-Gm-Message-State: AOJu0YypTUjO3/MqTpATV1ZarQrCg0RVzJRcqK1GmSH29dCd/tNvaPCL
	6Ppieg+Npw/4fo/TDLmZiucHa2uLOIAr3F3cEMyfbEnvf1h4uzDK
X-Google-Smtp-Source: AGHT+IHw8KfOLr4wweU0WvNfNFZsz6TpTv4zZskhdTsim+mkMrxkExM3yX2jf2+qysG2Rfaj9Z7MbOc0PCYYxVNN2Ss=
X-Received: by 2002:a05:6808:164d:b0:3ba:964:1742 with SMTP id
 az13-20020a056808164d00b003ba09641742mr6912482oib.20.1702642234999; Fri, 15
 Dec 2023 04:10:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202312151816.munFeE4L-lkp@intel.com/> <f06a9b6eac184cc648ae7444c480add6da87a84d.1702639801.git.namcao@linutronix.de>
In-Reply-To: <f06a9b6eac184cc648ae7444c480add6da87a84d.1702639801.git.namcao@linutronix.de>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 15 Dec 2023 13:10:24 +0100
Message-ID: <CACRpkdYtzmMrUAKcLfA=i5qmsddxw6afH9zKtiMS95EtatMsAw@mail.gmail.com>
Subject: Re: [PATCH 1/2] spi: pl022: delete description of cur_msg
To: Nam Cao <namcao@linutronix.de>
Cc: broonie@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 12:33=E2=80=AFPM Nam Cao <namcao@linutronix.de> wro=
te:

> The variable cur_msg was removed, but its description is left behind.
> Delete this description.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202312151816.munFeE4L-lkp@i=
ntel.com/
> Signed-off-by: Nam Cao <namcao@linutronix.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij


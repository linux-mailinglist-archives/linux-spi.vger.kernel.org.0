Return-Path: <linux-spi+bounces-1057-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8BE849E1D
	for <lists+linux-spi@lfdr.de>; Mon,  5 Feb 2024 16:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9980C287B6B
	for <lists+linux-spi@lfdr.de>; Mon,  5 Feb 2024 15:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC6B2D050;
	Mon,  5 Feb 2024 15:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L3yjfe70"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573FC2C6B6
	for <linux-spi@vger.kernel.org>; Mon,  5 Feb 2024 15:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707146902; cv=none; b=ujsjCbAtj/aSdD92pvuZ4BKuzO/ddU1180LTuSL7s6SN8A8ZVanVaQ0dBYZKpExrcgkN+BFDXR+bOXOcb3fGPDej/kHPJbhDazaC+PD397HudvxLENiDiLgjVZlGWCyEdx/mvSuvIzFcexsHD70I5flbKc11Cg+pH5NSujHt7lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707146902; c=relaxed/simple;
	bh=sDRyLlC3gWqMVU08yPO/L/S4ZvFI/bD4jpF5C0pvcss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m8P8rB7yumi+ogZZo6AdtGT88C7+dV3vARedYxBGFvJHkvPM3g6Xx9/ZOAFA95u1Cl3wfaiTSxywQAn1VyhVaxg1yLuI1N96PJCj4b74ewHaRV4us1GXTT/D/lteclj94DnMtC1X7LJtB25hyofrOadB+vkI5FDqbpJZ/Tw66DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L3yjfe70; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55a5e7fa471so5871829a12.1
        for <linux-spi@vger.kernel.org>; Mon, 05 Feb 2024 07:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707146897; x=1707751697; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sDRyLlC3gWqMVU08yPO/L/S4ZvFI/bD4jpF5C0pvcss=;
        b=L3yjfe708OVoJaMTw+YHmQm6WG891A5Wo+0TLwqIDoDB9PI6r1DaaqNlJqnzAZWxki
         43YatYJD9YGeKj0kWW+2dPk26KjztHzX+ZDXV3IksLUnbzE31h4sRntWEup/w80+lTrK
         n+5ibOKnddHB0CaLj1pdl30BIYo03fBWj/eMGzgOEDGS3M+NjUwtrP9xdvWKaC66e5W0
         m/nEgS99/NgfAWAtBrxPtR1lNB5X5ZQHY0WS9P4Vv5yKUcyEInokdYQb6a8MFOAOJJtf
         LPFD4Ck7WE+A+TvKfZ3y2888tpfzSBVtXPCepnAxgj3ZmxMu1MyzK2FtZsEVGhHjtnbb
         zk9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707146897; x=1707751697;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sDRyLlC3gWqMVU08yPO/L/S4ZvFI/bD4jpF5C0pvcss=;
        b=jpSSqJ1pJzqmN/uVoqNq611pI2/4HCKXevkhYPpud/yR85dkQG+fWIK0B1Na/9EITh
         odHObmKqxb4YwhT6itCNwPEYWtTEPa625ZCoyLOpJgJQDkFWiZXpa+XjaXUo21OQxZSc
         N2wUcnwegQTF38nFo4eLpOin44pcOVfp45YDzHvnMIYKkv0pLcvoELvyXwfgab+Po1Lg
         lzafxtVJ8k+e0fquxfarHbqJZW8k0j943FIO8vF/uDHxKDElfxSsTOakco4MICgAmci/
         odKSEwI2Mry5dGXLaiEMC6NxBMGQerRhv+4/mJ50mL4mXokkYT4NEEF5ijLOmq10NU/j
         9F5Q==
X-Gm-Message-State: AOJu0Yz6yOW84iDI/+xBCLcYWu22RA4urxS+7hbXMOAaTLztm6ANxcOe
	n0sJibtNt+z2dHDc3mELlutIxRjQgWh3a/QvGeC3VzPys4/ePt14p2MGiv5sM7pC2UQCwWdBU11
	UeB5SOI99UtXqtsDFVxkBR8n2Q31ii87PLyUROQ==
X-Google-Smtp-Source: AGHT+IGIbSdPg2kJtN19Mb0Xsv1cjow8kPEkOEIXkMaPHkzoWnTMAKzZWW0SuSwM277zl/168CsT5ROoYE/L2t/1/LA=
X-Received: by 2002:a05:6402:545:b0:55f:a1af:a1eb with SMTP id
 i5-20020a056402054500b0055fa1afa1ebmr4776963edx.23.1707146897552; Mon, 05 Feb
 2024 07:28:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205124513.447875-1-tudor.ambarus@linaro.org> <20240205124513.447875-6-tudor.ambarus@linaro.org>
In-Reply-To: <20240205124513.447875-6-tudor.ambarus@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Mon, 5 Feb 2024 15:28:05 +0000
Message-ID: <CADrjBPqv2O+au=MOxCoaLAAuQqOPTL7QDKcmEUUWgfAXbuWmAw@mail.gmail.com>
Subject: Re: [PATCH v4 05/16] spi: s3c64xx: sort headers alphabetically
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: broonie@kernel.org, andi.shyti@kernel.org, semen.protsenko@linaro.org, 
	krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com, 
	linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	andre.draszik@linaro.org, kernel-team@android.com, willmcvicker@google.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Feb 2024 at 12:45, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>
> Sorting headers alphabetically helps locating duplicates,
> and makes it easier to figure out where to insert new headers.
>
> Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>


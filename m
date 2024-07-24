Return-Path: <linux-spi+bounces-3944-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE0E93AD5F
	for <lists+linux-spi@lfdr.de>; Wed, 24 Jul 2024 09:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F31591F22BCC
	for <lists+linux-spi@lfdr.de>; Wed, 24 Jul 2024 07:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201094AEF6;
	Wed, 24 Jul 2024 07:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hb4BYxFc"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8307A46B91;
	Wed, 24 Jul 2024 07:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721807163; cv=none; b=Ey5Jkhkz1DEeDqOmHb7zbaWW1LVSo1UCF/q+jD72M/afldBERbX5mgOoeevJsKc/MDB9qx8+11TmVQ1EPu0xctvHzWLPjbW3AWF0GtvDXSBHISBtTc1/8UMyr6BLwVT3+GWu+KO1sg50o4XGx9O2+Xm5OnETbuItjTnQPYd5Uxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721807163; c=relaxed/simple;
	bh=8KoCmA+JnWG5GHt2isUS1L2Eg0/e4RGYIyMCqa/2anU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VyMh50oUk/56AceQsIcANAEXWkqFYPNzzznb/13OpIsEkCUX13R4kF1GmtGGKkdK7wdLxWJxG3YptNrFY6MnlZtgAis71RUGe9dtPqDr5YgOzdH19mE5W6gLhXuRIxeAI6ScNbakAhpLIdBOmEkvXkyp6M4292Z4PTThP2uABU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hb4BYxFc; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-368380828d6so3545190f8f.1;
        Wed, 24 Jul 2024 00:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721807160; x=1722411960; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8KoCmA+JnWG5GHt2isUS1L2Eg0/e4RGYIyMCqa/2anU=;
        b=Hb4BYxFc8doCo2xmIEs8QsXR5u8CVdZ3by27QOpoqpFaxDBT3PQ2ArqIIQ/Bnh2UVI
         W7SVpaVWY4fJ31PP9F9L1WBB6moS7+zZ9fbzm66+RsNLt3sgJrFu1Cj6vSCIdn4WikF6
         mi7sDfyvHRmb4N2w4lTCrVQCJwnOolty8Ru6zLf4aDyaI8jMXDjXD3q6rTysIII4fYut
         Kw/VWaUah+PaBNvFu6OukgI0tcjs+wc+lyJbM99317Xl4v7LQaPGkYwFGbdWLKqLW5Ze
         OhejHgeV58cReEjRUTf9V2FLDiZupps6qkkZdvmMQntDRZwoY4OmsEjLA8go70YTRtEA
         oKTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721807160; x=1722411960;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8KoCmA+JnWG5GHt2isUS1L2Eg0/e4RGYIyMCqa/2anU=;
        b=fxbNtz25IjsBFDMWOiaWkBTnXxVaKmtTEu+P6XMiFyDPVyErafJjIAZXPhaN5zy3T3
         cWOGrjpPLnAzuDvAIPSFhbAmhET+mp41iOlgPh3p3MRG5N9qa1lD1TOhVwim3+QSqMAv
         KWIq7yJZsQiyEARMjmoFiGXhcEYvP44exEV7oL9P8LS1/Vbg5oOkaSGrfpCsxPosanBE
         ZtMg5WbPgNWJP4RhiLunFVC1QfUcMwLRsn9gAF8GYz58TftbpBEEc/oNrcAea2leyHry
         yxOv4mByZPjROBS4XIwzx5BMcv5r1WES9DfmqqRXPlA4+rkYoCqSbbUp/AgLbMwIRd8w
         38rw==
X-Forwarded-Encrypted: i=1; AJvYcCXZuUAJ5vcZGsX8gQ2//xzd272D7z5Ax1T42PV50UDDLyhkuR9RT8kuhx7qaInw8QONJ7c27JC+/Ghe9x1O3oGozK+YCKGAkhyGCLV7elun67ZDXwSMJJoQuFXbn0/xc/vRG2ylbf6I
X-Gm-Message-State: AOJu0YzpyGupoUWdxe2GmqR6BLChUuDtUR1I2KbF0WBerUdZi5+kq6Rt
	+J7ASFqxGuNl7hM5jKQ8492NE3xexZz2P0WfLEDlUZFEAsja3xZJ
X-Google-Smtp-Source: AGHT+IHO2VhjrBItnZjQ1/CCPoY+qcfvnVMk/WY2GxYprSVed+mvtBH9RtHoJJVCcb7QgvOwoKhWQw==
X-Received: by 2002:adf:fc0c:0:b0:368:714e:5a5e with SMTP id ffacd0b85a97d-369debf8bbbmr4277080f8f.2.1721807159640;
        Wed, 24 Jul 2024 00:45:59 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:359b:e801:d44:32b3:6924:10d1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-368787eb6b0sm13535315f8f.90.2024.07.24.00.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 00:45:59 -0700 (PDT)
Message-ID: <05203de8fde109255b6e99a08e57037525a629ea.camel@gmail.com>
Subject: Re: [PATCH] spi: axi-spi-engine: don't emit XFER_BITS for empty xfer
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 24 Jul 2024 09:45:59 +0200
In-Reply-To: <20240723-spi-axi-spi-engine-opt-bpw-v1-1-2625ba4c4387@baylibre.com>
References: 
	<20240723-spi-axi-spi-engine-opt-bpw-v1-1-2625ba4c4387@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-07-23 at 13:36 -0500, David Lechner wrote:
> This adds a check on xfer->len to avoid emitting an XFER_BITS
> instruction for empty transfers in the AXI SPI Engine driver. This
> avoids unnecessary delays caused by executing an instruction that has
> no effect on the actual SPI transfer.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>




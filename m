Return-Path: <linux-spi+bounces-2927-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E69EE8C8CF5
	for <lists+linux-spi@lfdr.de>; Fri, 17 May 2024 21:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90E6528398A
	for <lists+linux-spi@lfdr.de>; Fri, 17 May 2024 19:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679DE12FF6D;
	Fri, 17 May 2024 19:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Re409t6S"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05441321D
	for <linux-spi@vger.kernel.org>; Fri, 17 May 2024 19:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715975401; cv=none; b=DIU5VH2SgiVouEuZhhijDAcF2IisvCpLyndpqBVupQS+uIZ8QDgwR1kup2iX3lGhJ+BDNAIgUdJ/wajb2ppUqWqKQ36GhpcR5FNYhisHRNXaUKyWJaBZqGknHSDkT4wPzddrDIC2WTBLQRHZ4lWX84HHB/CR/5yk+MgJPn489gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715975401; c=relaxed/simple;
	bh=qxfsT7ecf4gb5JgTuu3Xv6rMxJDtUmvA5c8dvCMJZdY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=IVxkiYysZZ8HSLgFXY0eImQg8+WeJ9G1KGfRcl7U+gfMCXjNfM+ndJ0sYiYWqozm7XDti/ecrbJw+tdAi0cZ3M3KlIGJHcytp0NVXlMCKL6VzeZRfvHEibU366zyYJhURLddNnd45Ibo98GmcynyCdvjDXJtIcssul6Z2hILI/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Re409t6S; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e5c7dfe277so1288745ad.1
        for <linux-spi@vger.kernel.org>; Fri, 17 May 2024 12:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715975399; x=1716580199; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DkC02ajmDp8au8nOQAmSiKZwlbDJdPCrp7KJQmbB5LI=;
        b=Re409t6SRct4M/kyvW8siWjRHbh+Y0/tygAlmRBA1dCo9R6I7mXwqh8v4Uu/kacZsg
         oXGsVAeIxCNEIOA4UTJJzkuVFWL8QLMtuPADbvSzzphaYnVP3/GGqlPinNl5/uPZE6NZ
         dLVlRYkIbKArbD7uGQyCQBt/0HX2VBhvjN+rFhDYQZ9tYyKMs33XtNvkpcjadzo8ajwn
         QTxBRZ6q5zpKHcWCNbrnMOMFd9Oby7FJMhn5Rku5YX3cYFneHjwvxnyKH2D6vi4tEJ5e
         xWJfYSplmdq67hQIiZVHGX81BhrswGWwDtBmvYqgpq14KTZ6OfAVnFQ0QO9l0G8zrE4w
         83UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715975399; x=1716580199;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DkC02ajmDp8au8nOQAmSiKZwlbDJdPCrp7KJQmbB5LI=;
        b=jurPEdK4sdPv+6X+klnPjyPaEfM2Jq0HfxFA96KIUEQY4V7WkngoUKGACgQRfSnLCO
         Ae1WL8QDHCkAO/VNAYGWf4ZW+8OT339U0O9XkR8cq0786eAG1BBrumYe6nwwtrZ3tAL3
         cpwXY1F/HsnGsM6KPVmnYwy3groZNOb0eCyHfZ20PhwoQ9dc4ghPbydJn3QqM79SvD/P
         Xgs4tBDWpsjsBQF6QeauoojHSbZ1U9ZNROFfeSAIPEX/8VzTlpnFd0nr0NfzZrtKu+3+
         yi748Izow0z+RklaDxPQeYc852PMnLbaRuWB+Nw3rgQ1WUBPtbMaQk67iTohWGNeSJiY
         wYKw==
X-Forwarded-Encrypted: i=1; AJvYcCXPwTZSsxsTQulvABCNO8J+QVH88jEn01oyYjso28L1LB1oKrME28F8LmWZpEt0nr6Bpw9q5OAzeSaqwxAExKPJ1NOYNBNASb1M
X-Gm-Message-State: AOJu0YxS1TxI2K75EBgcBSk3Eae/1Tgd2N48Yn/rCjkaRypGoB+Hg7kn
	+b6cfOke44B+k0ZeVxeojZjkQCL+eN1+RvNKa5yZdUwOIml7w2Jx2BUnmDr1m6kaqyBehKyt7GE
	xj2c3VnsLkZ1XHD74KNpbjb0ylebBd7V5U78=
X-Google-Smtp-Source: AGHT+IHoGq3IWj7advFtjZZYLQJht5smm9rTMguTThuxymXQmX3xKdysGKnWcNRH2uPZihxbeifZaQku1+dwYWHzZSM=
X-Received: by 2002:a17:90a:8c7:b0:2b6:20a0:441e with SMTP id
 98e67ed59e1d1-2b6cd1f1b31mr21460875a91.4.1715975399291; Fri, 17 May 2024
 12:49:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 17 May 2024 16:49:47 -0300
Message-ID: <CAOMZO5Bp1kfq9C7HpK=V+v=LytZFdbfcvgg1MmhYqqkntHVb2A@mail.gmail.com>
Subject: rv1108: SPI DMA failure
To: Mark Brown <broonie@kernel.org>, Andy Yan <andy.yan@rock-chips.com>
Cc: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
	linux-rockchip@lists.infradead.org, 
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	linux-spi <linux-spi@vger.kernel.org>, Otavio Salvador <otavio@ossystems.com.br>
Content-Type: text/plain; charset="UTF-8"

Hi,

On the new revision of a rv1108-elgin board, there is an Infineon SPL9670
TPM device connected to the SPI bus.

On kernel 6.9, the following SPI transfer errors occur:

[    2.747002] tpm_tis_spi spi0.0: SPI transfer timed out
[    2.747564] spi_master spi0: failed to transfer one message from queue
[    2.748239] spi_master spi0: noqueue transfer failed
[    2.749039] tpm tpm0: tpm_transmit: tpm_recv: error -110
[    2.749569] tpm tpm0: TPM in field failure mode, requires firmware upgrade

The same issue happens with older kernels, such as 5.4.

If SPI DMA support is removed like this:

&spi {
    pinctrl-names = "default";
    pinctrl-0 = <&spim1_clk &spim1_cs0 &spim1_tx &spim1_rx>;
    /delete-property/ dmas;
    /delete-property/ dma-names;
    status = "okay";

    tpm@0 {
        compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
        reg = <0>;
        spi-max-frequency = <10000000>;
    };
};


Then the TPM device works correctly.

An old RV1108 SPI bug was reported by Otavio:

https://lore.kernel.org/linux-spi/CAP9ODKpW=h6SVtsn-uuDQ4+TgR0NnjBW==8vwyQD4+x_dbFzRQ@mail.gmail.com/

That indicates an RV1108 SPI problem after moving from polling to IRQ.

Mark's made a good point in reply to Otavio's report:

"Does the interrupt ever fire?  I'm wondering if the DT is wired up
correctly for the particular SoC you have, or if it's even wired up at
all in the hardware."

Can we get some help from Rockchip to clarify these issues on the RV1108 SPI?

Have RV1108 SPI DMA and IRQ been tested by Rockchip?

Are the rv1108 SPI DMA/IRQ descriptions in the rv1108.dtsi correct?

Any known SPI hardware issue on RV1108?

Thanks,

Fabio Estevam


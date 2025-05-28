Return-Path: <linux-spi+bounces-8318-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBD5AC5E08
	for <lists+linux-spi@lfdr.de>; Wed, 28 May 2025 02:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8A90168E7C
	for <lists+linux-spi@lfdr.de>; Wed, 28 May 2025 00:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993618F77;
	Wed, 28 May 2025 00:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dOxJDg1w"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AD13208
	for <linux-spi@vger.kernel.org>; Wed, 28 May 2025 00:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748390930; cv=none; b=lsYzAa1wPirEB6PSddZGY+oIWWduNBJ2+YwP2qOtwx1vsgqEguBeFRyBKgdoRRB40X96etHDlDfnSoaGtf0kPqPTmhVO9p1tFnI4aa/y9kMoZe0FECyyqxngXjQoVQM1lPVMpV2BndXui2qHuXWvtS8oaRB+98lftfmwdm/DfBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748390930; c=relaxed/simple;
	bh=TR0ZxYypZZy0i1CaeTOe+YTdQQcFYzl9mwiHMZdHDFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aP7cZk0q+/wEdXLZgivcxL6Ll+H/7a6BJIQYJYTie7qdD8pjKx0lq73SEhFJ/vcSptB1wv3pHz9jcpqP12ugSU0tQXmj3wdwnB6ywEybeIZ3n++BW3DmPkDsYU2FK2Hla9MZUzkJJEYtIoIpbxP0fCY96yS2xrb1MW42MlPqBjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dOxJDg1w; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-602039559d8so7809901a12.1
        for <linux-spi@vger.kernel.org>; Tue, 27 May 2025 17:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1748390926; x=1748995726; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=edlHaC7UGBhxSlzvX5IeW6JsmYljoWpUJVytG195zA0=;
        b=dOxJDg1wNE8ydeBSTmW/Q+ZCDhDUqp1ic+O+xllpZJPFNQ+tLTmRYkorkWxNSrIjdh
         pl+xwwKENb3mZcX54EcnQzZQ/EZO2NPYUYe/gYjqLXn1vc5cjjvfqGqrfSBTcFumMeoh
         Tf2W8NFtzWgFzGot8873bpkL+u2dLwQlBG4VM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748390926; x=1748995726;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=edlHaC7UGBhxSlzvX5IeW6JsmYljoWpUJVytG195zA0=;
        b=skMmGw5W3OvqzVaUmheuHXKq6T9OW5e2ujqxTqxknt0HQRzCvm7pg3xygor4Dl6h/+
         +t7X2X7lO/53MS3R6OmhTXrD+7iRTZnbVRxu2yXfPcraEO1NV5CqAW5a2tPbGUT5Ewym
         PfGaX5GUxadSr3RzWfoNjDKzO3JviF9C8g1yJRQXAZNGCZ6KNhB9qm/tbuB/9Yft8VwN
         XAoC9/ODpBrUGFZRYBVcno0+5KsmbpluiK5U8m1i5ogs2CAjsHA2BxkUksTydEO+0iWX
         vBJA+A9RUkVJD38Wo+1WawYTZGvdf3r3rZXUYbRR1lmIUz9pYx0sJ7Ngw44i0vn4hi0U
         deUg==
X-Gm-Message-State: AOJu0Yyk+jNdxQxsTiOtqdwuPGlvFqLtJttQOdfjTqdP6fkQ5j9XfV60
	hHk+nnnH5Ew4VwJZsbEwLONX+PXWZEYxpL+FiQ39UeqdL8p8e1gF4vbNoxsHnrXhsMsGJ5uIBha
	iATbCoDo=
X-Gm-Gg: ASbGncthM6v3yC8P4SRP8ADk9KDSovEnAlk/8Hs1MXVN0fCO9fYXU3//yXVaix8rRpS
	V0dU4xruIlrAB/0Hcgthf+lYTHz3TXFGpWuz86DEe64pk7OmRNDudAcASRnXulCvFfA/tT9GgQF
	G5KQOVKuARwH+RJUK2YUrAKz+WCC3vmEfyKhBbPH0Tau62gc6dntUXNAYTc752HpGrbxERwCHf0
	EHizRzXrUogACaAT5CLu/bKdEw4lbDJpVHMPnHgycvWMx12gMp0hioTZKgDRYq5ISFx9cFJGhym
	gv37BOpsTcCfkHHiIbGeiu7Bzj91ci8X/LxM7snOTSEM5A6vZ3qcSJI6vAxtcpGjKiJPByE2nR8
	lKV+njXCYc6Xl1FJbe+QfemkG0Q==
X-Google-Smtp-Source: AGHT+IG8M6OnlwkHvABRC2aHVMeofcS17jGjUdBxsGasckVlp5CsNZny+M5Oe275OTkw8ZMFBRTvvg==
X-Received: by 2002:a17:907:3d09:b0:ace:5461:81dd with SMTP id a640c23a62f3a-ad85b00b904mr1444043466b.3.1748390926572;
        Tue, 27 May 2025 17:08:46 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad8a1b5b707sm7099066b.169.2025.05.27.17.08.44
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 May 2025 17:08:45 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-602039559d8so7809858a12.1
        for <linux-spi@vger.kernel.org>; Tue, 27 May 2025 17:08:44 -0700 (PDT)
X-Received: by 2002:a17:907:3e06:b0:ad5:27f5:7174 with SMTP id
 a640c23a62f3a-ad85adbbbf7mr1420194866b.0.1748390924696; Tue, 27 May 2025
 17:08:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4a1559fc9c5d1fec91f1ac5d425871b5.broonie@kernel.org>
In-Reply-To: <4a1559fc9c5d1fec91f1ac5d425871b5.broonie@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 27 May 2025 17:08:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wixqijS-ptVfduV-tAdfKjnLUBicwsXL1xf5PETfktv+w@mail.gmail.com>
X-Gm-Features: AX0GCFunwcx56f-t3WhtxF7QDIIPFE08vsP33GUiGJbUKXYqA7CrWkCSD440jBs
Message-ID: <CAHk-=wixqijS-ptVfduV-tAdfKjnLUBicwsXL1xf5PETfktv+w@mail.gmail.com>
Subject: Re: [GIT PULL] SPI updates for v6.16
To: Mark Brown <broonie@kernel.org>, Raju Rangoju <Raju.Rangoju@amd.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 26 May 2025 at 03:30, Mark Brown <broonie@kernel.org> wrote:
>
> Raju Rangoju (4):
>       spi: spi_amd: Add PCI-based driver for AMD HID2 SPI controller
>       spi: spi_amd: Remove read{q,b} usage on DMA buffer
>       spi: spi_amd: Add HIDDMA basic write support
>       spi: spi_amd: Update Kconfig dependencies

So the Kconfig changes made me look at this, and this is just *odd*.

The driver stops using read{q,b}, but why in the name of everything
holy did it then convert to this insanity:

        u64 *buf_64 = (u64 *)op->data.buf.in;
        [...]
        u64 *dma_buf64 = (u64 *)amd_spi->dma_virt_addr;
        [...]

        /* Copy data from DMA buffer */
        while (left_data >= 8) {
                *buf_64++ = *dma_buf64++;
                left_data -= 8;
        }

        buf = (u8 *)buf_64;
        dma_buf = (u8 *)dma_buf64;
        while (left_data--)
                *buf++ = *dma_buf++;

which simply seems to be a really stupid and over-complicated way to
write a regular memory copy:

        memcpy(op->data.buf.in,
                amd_spi->dma_virt_addr,
                nbytes);

because I'm not seeing what the point of writing it that way is.

              Linus


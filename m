Return-Path: <linux-spi+bounces-11466-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4482C7CCF4
	for <lists+linux-spi@lfdr.de>; Sat, 22 Nov 2025 11:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 720713A87FE
	for <lists+linux-spi@lfdr.de>; Sat, 22 Nov 2025 10:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2B82FA0F3;
	Sat, 22 Nov 2025 10:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="Aylfsbjq"
X-Original-To: linux-spi@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385C52C0F63;
	Sat, 22 Nov 2025 10:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763809056; cv=none; b=YzGwhzPx3/yI+VeEaiX+pLxhVqAQxe//XZseItTj38ZX0VaGUF2i9Slgjfvp+LHyw0E/vJxEH4PpUrlT8lvMQXy5jsGfc/pk3qWOdt7nPCw0gLqlM1aMsQaeHtD9IBy8Mu3QdOFrTqRGV382eg9KVCFX+OOyBUVHPebRcjQF90Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763809056; c=relaxed/simple;
	bh=h5YLa3eDM2goQ4CmWJKPcrCUlbWSJlL/IVHW5pqO+1c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EeGeMlg7irAxWJUQ7XHC9v7lrv0zy9tcLK9s1IgWWoWYsKVJlQ7by0NoLfgcZDFlzQx7T6aZMcm6mDERyfnN4Bz0gHOust6+SsLDeFI7fydtXlMKpS5sHY0P4qyGFqbM8/nc+LzaG32N/eXh82DVjG3dvaZ49RvnEdbPzaPSuBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=runbox.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=Aylfsbjq; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=runbox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight@runbox.com>)
	id 1vMlIz-00Emo4-Da; Sat, 22 Nov 2025 11:57:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date;
	bh=V3JXOeeVFX/U55I06/2lcgfvRbHIHmahUxE40Ef7grE=; b=Aylfsbjq5u4ZiFqvncRmYuvPOY
	I7XYFUl8Fp0g92yHJ5NFOY8nox+lCXK64Eb2JXBu+P4FRJziBxs4+40PJtPeF9lsW3yuJpupr0STa
	yl8lH/IZgqP/55Q5ClwZ9EGcg462fre+oK/2wVCmTBShKysHMRdNL/NmaPy8Rhu1INM1xyQCYGMNt
	kytI74x1JrcI8BoCCHp97jGwq87KjEfHqWLeToui75qKSohbC75MarXg6Qik3DzhhCP2RqsX7uyQm
	6hlRv7u7IYXjAznfKWP/9yOMbJr/lAkAQkpq4P/2Pq1rZTH+0WsiZIK1l7K3hJDK7P0DVxShrQrOA
	Aexd6XLg==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight@runbox.com>)
	id 1vMlIy-00089T-Rc; Sat, 22 Nov 2025 11:57:24 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vMlIs-003z81-Df; Sat, 22 Nov 2025 11:57:18 +0100
Date: Sat, 22 Nov 2025 10:57:16 +0000
From: david laight <david.laight@runbox.com>
To: Frank Li <Frank.li@nxp.com>
Cc: carlos.song@nxp.com, broonie@kernel.org, rongqianfeng@vivo.com,
 linux-spi@vger.kernel.org, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: spi-fsl-lpspi: fix watermark truncation caused by
 type cast
Message-ID: <20251122105716.24769251@pumpkin>
In-Reply-To: <aSCRFu2koh/w7ELs@lizhi-Precision-Tower-5810>
References: <20251117030355.1359081-1-carlos.song@nxp.com>
	<aSCRFu2koh/w7ELs@lizhi-Precision-Tower-5810>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Nov 2025 11:19:34 -0500
Frank Li <Frank.li@nxp.com> wrote:

> On Mon, Nov 17, 2025 at 11:03:55AM +0800, carlos.song@nxp.com wrote:
> > From: Carlos Song <carlos.song@nxp.com>
> >
> > 't->len' is an unsigned integer, while 'watermark' and 'txfifosize' are
> > u8. Using min_t with typeof(watermark) forces both values to be cast to
> > u8, which truncates len when it exceeds 255. For example, len = 4096
> > becomes 0 after casting, resulting in an incorrect watermark value.
> >
> > Use a wider type in min_t to avoid truncation and ensure the correct
> > minimum value is applied.
> >
> > Fixes: a750050349ea ("spi: spi-fsl-lpspi: use min_t() to improve code")
> > Signed-off-by: Carlos Song <carlos.song@nxp.com>
> > ---
> >  drivers/spi/spi-fsl-lpspi.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
> > index 8da66e101386..065456aba2ae 100644
> > --- a/drivers/spi/spi-fsl-lpspi.c
> > +++ b/drivers/spi/spi-fsl-lpspi.c
> > @@ -486,7 +486,13 @@ static int fsl_lpspi_setup_transfer(struct spi_controller *controller,
> >  		fsl_lpspi->tx = fsl_lpspi_buf_tx_u32;
> >  	}
> >
> > -	fsl_lpspi->watermark = min_t(typeof(fsl_lpspi->watermark),
> > +	/*
> > +	 * t->len is 'unsigned' and txfifosize and watermrk is 'u8', force
> > +	 * type cast is inevitable. When len > 255, len will be truncated in min_t(),
> > +	 * it caused wrong watermark set. 'unsigned int' is as the designated type
> > +	 * for min_t() to avoid truncation.
> > +	 */
> > +	fsl_lpspi->watermark = min_t(unsigned int,
> >  				     fsl_lpspi->txfifosize,
> >  				     t->len);  
> 
> There are thread discussion about min() and min_t()
> 
> https://lore.kernel.org/all/20251119224140.8616-1-david.laight.linux@gmail.com/

The big comment even carefully explains that the two types are unsigned ones.
So a simple min() is absolutely fine (and the comment can go away).

The old typecheck in min was just so stupid.
In this case the 'u8' variable is promoted to 'int' (they always are)
and then converted to 'unsigned int' to match the other type.
Even though there is an implicit 'int' => 'unsigned int' cast it is
impossible for a negative value to become a large positive on
(which is the only justification for the type check).

I'd check the file for other uses on min_t() as well.

	David


> 
> Frank
> 
> >
> > --
> > 2.34.1
> >  
> 



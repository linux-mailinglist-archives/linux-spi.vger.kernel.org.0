Return-Path: <linux-spi+bounces-7243-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B93A6A52C
	for <lists+linux-spi@lfdr.de>; Thu, 20 Mar 2025 12:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8098B7AC453
	for <lists+linux-spi@lfdr.de>; Thu, 20 Mar 2025 11:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF9222157E;
	Thu, 20 Mar 2025 11:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Zoqc6Eox"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A9521CA18
	for <linux-spi@vger.kernel.org>; Thu, 20 Mar 2025 11:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742471016; cv=none; b=XkaEAPv+vCnMYR8tl+w7h0F8/xa0wxcWsmxM9ykxqB9E0RBZNAwZh0eOJ0JFXsuXDVg/0519Wg0Y4XDF9TOhjllsv9eSaxu54GKOHo9Rb3k/AIz9hDwQ5+pyMRn8Mw/Nme6Q4ybgwoVuYn029glGn+jyQTRFL5BN7Lq0V7wzmo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742471016; c=relaxed/simple;
	bh=QocqAbZ08O5BhqwJt2qkDxM3p5JVemrgvncg1R1Btw8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bj7bZ4+Np7bFvJp3Tq3YBAqW4Wel8usrN3KuL5+37tKG2cAW7TK5Aj27/8tmmRV19swtR3Z9VWK548KwtylRwZhNj6REtf8xaKyMjJRbJJx8nerMG6Jy3Kl5NmKHyn5MwX9lxQVCzD8+1Ci3wknoweitWDN26+F7Oeau+b83HYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Zoqc6Eox; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3912ebb8e88so92726f8f.0
        for <linux-spi@vger.kernel.org>; Thu, 20 Mar 2025 04:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742471013; x=1743075813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=awrVXoOgwgbowP/3YV5mb7Sfi/C/P3UfmEoAWYPQvvE=;
        b=Zoqc6EoxibkNrftGMQrWpDzOjmv4h3zy4Bv9HY87+6fWP/i33DVhC43UBeQxuislkl
         Q3o2ALxxzBQ46vujJVhfkax0r/HSFqeeM97Zsrmt6pHojhmFDOtZUOH4J1IMiHmGVkGB
         2Ggh7mpMnWcWnziSJJflDVn8fG/WVZmneEFzkWeBNUBP5YiqNM2gmpklUoVBHjhoEPUg
         TJMcXgQ/9FuLAMdBbXw67NtekTMt/DfmWoNIlTXtE9WJp/5Z6xSCxOMAwMvBH2hW0nON
         zjyFDCwhy0qZMPES8ja03617PJJnHU9EfG30RFZpcTqTv0rJHiK97FqZKo4N3MTy54AV
         LOJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742471013; x=1743075813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=awrVXoOgwgbowP/3YV5mb7Sfi/C/P3UfmEoAWYPQvvE=;
        b=t+Toyo/nN31QMkKZJURxqMI/XDKBcfH6y/b2/K9NFh/xZ5RSliUoD1jPNyER8sLsIm
         97KD0N9+ftx6UyHsbwWWAcA/h7XJsX3KkPG8N3EQyloHFHXi765TcZQO8vCQuRv2Bhsa
         Bu5oGNhPwwrci4RfdCtZ1hjH9Wx5HDPMOocuOxBQ/2HPMn8aYrA7qq5aCMtmYYMH7Zvx
         lsi4dPHIREH2vdghjbtzg157KDXS4lUh5MC6uC4uXoWlULZjn+BxxYOt9bhO7Vy8E2rP
         x937RuyTr4LVWyCiAypxAx74sQZ6/L44G94si0H2yglSSC6qhMdmqbxLlquJmAIZKZy4
         4lPg==
X-Forwarded-Encrypted: i=1; AJvYcCUo39iZAQDVUAOpmsXQAYwwII55jDD0NVJDGWejo7q5EbUcQSPmfnorliPJIyUunxpP8MqxWa7PC4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIVyMrPMPIU/V6I30isgMcmWNWjaIp7HFFTCroPl+toay9wMXa
	tlC+rFZL6aBgdEgNJu5Ufr/3G7Hm7UPLEXreiKddUAnj4C43Hd/vEhJOyREGHeFxpW829ehCvd+
	s
X-Gm-Gg: ASbGncvpHnGV68Y09e423ZttG4yTEg2ueMCd+foJaIwJlYR9KCY/X4EtFuxfb06YdJx
	9EKAPwjfstA44U9EaWqf6sMBH6TEZv3nHR4i68UeKGlB1t4+c2W1Pwl5sNSPvDxa9LR4g06A/fj
	9FENIVK4FpoNXgkUmXDoyPKnCCQ2rl8cKQbN5ctAmqa+Zo+aA6l/vmSkDPXi0lOHhL00fgY+1JQ
	iiTKKcSRPTV6zpRiEJBkngdgWceCnnVCU/IgFd+aiCom8Id8lKBUW01n9cgu3J+cYv2J5nsbw18
	dLugRYOIt5oPQzDqjcAThzp5V4eXZau+m8UePHg4Jsu6RN0JaRKrbe9GRNu2JesMwdna4OA6GVe
	W7hnOxl0r/9rSEbSvzvwY2pp/gJl2MXheusRTlwGjuotxuIxkdQ==
X-Google-Smtp-Source: AGHT+IHpoeXYuSVaprnjvdPl/2KuINI57p2j38u8R+niUsmvbeZxMH/KDG1MEHxH3qO539selj/9zA==
X-Received: by 2002:a05:6000:18a3:b0:382:4e5c:5c96 with SMTP id ffacd0b85a97d-39973b4672amr2382210f8f.8.1742471012795;
        Thu, 20 Mar 2025 04:43:32 -0700 (PDT)
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43fdab7asm46308595e9.29.2025.03.20.04.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 04:43:32 -0700 (PDT)
Date: Thu, 20 Mar 2025 12:43:30 +0100
From: Petr Tesarik <ptesarik@suse.com>
To: Mark Brown <broonie@kernel.org>
Cc: Grant Likely <grant.likely@secretlab.ca>, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: Ensure memory used for spi_write_then_read() is
 DMA safe
Message-ID: <20250320124330.480d652d@mordecai.tesarici.cz>
In-Reply-To: <20130205142128.2E28D3E1265@localhost>
References: <1359268504-24937-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20130205142128.2E28D3E1265@localhost>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 05 Feb 2013 14:21:28 +0000
Grant Likely <grant.likely@secretlab.ca> wrote:

> On Sun, 27 Jan 2013 14:35:04 +0800, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> > Use GFP_DMA in order to ensure that the memory we allocate for transfers
> > in spi_write_then_read() can be DMAed. On most platforms this will have
> > no effect.
> > 
> > Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>  
> 
> Applied, thanks.

Hi all,

I'm sorry to revive such an old thread, but I'm trying to clean up DMA
zone use in preparation of killing the need for that zone entirely, and
this use looks fishy to me. I'm curious if it solves a real-world issue.

First, the semantics of GFP_DMA can be confusing. FWIW allocating with
GFP_DMA does *not* mean you get a buffer that can be directly passed to
a DMA controller (think of cache coherency on arm, or memory encryption
with confidential computing).

Second, this code path is taken only if transfer size is greater than
SPI_BUFSIZ, or if there is contention over the pre-allocated buffer,
which is initialized in spi_init() without GFP_DMA:

	buf = kmalloc(SPI_BUFSIZ, GFP_KERNEL);

IIUC most transfers use this buffer, and they have apparently worked
fine for the last 10+ years...

What about reverting commit 2cd94c8a1b41 ("spi: Ensure memory used for
spi_write_then_read() is DMA safe"), unless you have strong evidence
that it is needed?

Petr T

> g.
> 
> > ---
> >  drivers/spi/spi.c |    3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> > index 19ee901..14d0fba 100644
> > --- a/drivers/spi/spi.c
> > +++ b/drivers/spi/spi.c
> > @@ -1656,7 +1656,8 @@ int spi_write_then_read(struct spi_device *spi,
> >  	 * using the pre-allocated buffer or the transfer is too large.
> >  	 */
> >  	if ((n_tx + n_rx) > SPI_BUFSIZ || !mutex_trylock(&lock)) {
> > -		local_buf = kmalloc(max((unsigned)SPI_BUFSIZ, n_tx + n_rx), GFP_KERNEL);
> > +		local_buf = kmalloc(max((unsigned)SPI_BUFSIZ, n_tx + n_rx),
> > +				    GFP_KERNEL | GFP_DMA);
> >  		if (!local_buf)
> >  			return -ENOMEM;
> >  	} else {
> > -- 
> > 1.7.10.4
> >   
> 



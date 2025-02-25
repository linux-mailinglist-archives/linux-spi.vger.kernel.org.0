Return-Path: <linux-spi+bounces-6901-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 802DCA431F3
	for <lists+linux-spi@lfdr.de>; Tue, 25 Feb 2025 01:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AAA07A9580
	for <lists+linux-spi@lfdr.de>; Tue, 25 Feb 2025 00:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A045923AD;
	Tue, 25 Feb 2025 00:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Byky8Eoy"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058ED17E4;
	Tue, 25 Feb 2025 00:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740443951; cv=none; b=nhW98LwyNPn00AkzEFPhnylwmgjFKD3k+PqsPKXasrWqtv4Cc7wodV1rqou7xvNZtUyLxlcNvsE25Vl4p3oUAdZi5FyevdUhjcNPA8+LdTxwSodTZwzX6k0Ci4hnI5MHiONCwE5ChYqeqweftD0I2AJYxt72Lt2RSGC86btBeIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740443951; c=relaxed/simple;
	bh=Bi4cE+bok5QeHCT5gaLJWHNcaZlnJozQJCrrPLsDB3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uNDhJEF0VOnnAfQaqWjnEhuEtN/Un7pkcjXQjmnOwLhC5RE4km9FspK9JCX5ajuWeH9lgbu0OGxeGVXYaEgAdmh3GBOZ6jbnBmmqQijaZhP5DERly6fDrpDIA/RHqeTNBUBA8cBBKRBmsr9VGuPFpfmodVbQO7UQYcD1pT9NRbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Byky8Eoy; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6dd0d09215aso35604956d6.2;
        Mon, 24 Feb 2025 16:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740443949; x=1741048749; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WZV4VbgAA8psv5vM2PGHPKcQafhnuCZSauoIR3CxAI8=;
        b=Byky8EoyjbZ2Cj0FGmCQhr2Cul1FpJOJ8HhK3H+9+ypzRRJhPjuuh62B9IkXNL5OUj
         75z8bg3Z4sv7U4Tt/7pncC1jP6U1Lq/m4RM9NFQ5K90Y9ZYwKl21epv0ZNz0jxn1hCRt
         GkczSd9j9898tlS6byR9gGYzVNVrPFZfjKdtEEovMHgL9vMy9EroxFCLHV8KBinNASWK
         aFamCHm5P2SU1y5CosbRJCtJTmO5D/6aU+pqBW38778rEjC+akHk4Y8G9Z90XKOR38Lq
         hasy8C0x1n3bodtgSa7pskJqUlrZIYpQhqGHsH2zAFiI9LazWuPJL2bI721VqEFmzMvW
         i3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740443949; x=1741048749;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WZV4VbgAA8psv5vM2PGHPKcQafhnuCZSauoIR3CxAI8=;
        b=Egcu86z2QsUsr8eB60G+MiiaYjDq7w8Lxa4pTQPTpRVU8neHJi9bbOQBn415WxQvrg
         /gvbw9del7zHSmAnCvCFSCFpzSjRoyi+en4fiKOQMZ1t8fAumrXQ5c7Kyi/QKTlDG4ke
         FplDnp8KROQ6CrbWu78kq7gLaHsK7iDvq0bW9Nh7miymiLRGnUXrIW2AenQBCfU2Q0l+
         /hmFrwDHhTw502jehMNK5ZkmalseCcYQexacdvLhIuihpOYLyXhaKXWXO/uPxV0Il8yV
         zgRZUdmLRuVWHZAmLuFL19TzTvbyZwpUcZBIB/JI3xpT5m4hSf/3O/XhFOMLzJYULCDe
         5fPA==
X-Forwarded-Encrypted: i=1; AJvYcCU0bA+iBh5/Usm+tBS/+oou7IgkvIqEJA/SvJ2l8WRSgO/C3BCjdlxWVbZyTvkTzPqnZ9Dej4PUmrxFei7w@vger.kernel.org, AJvYcCVV1BlbMe2raHm+75I0j0UH1o+Kpt17IenFtN4p3tY2s8kxDgs6OKqGy7SDUDjLILskamtCLjwmgKUJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxA9mAnBhkA1f1bnomD6KMJ2sM/v5GvqV2C3wUhhA5r6WKDgTf7
	ygyWlE21g8RtJqwI/nj7Oa+ZFNHDlHNNoUmVIAEj4YItgjNc4FLJ
X-Gm-Gg: ASbGncvUXXAV2gAzZYBDHzY2CMnEQGf2tCjFjtumN0NtHMzWBjghH53vtYu7T9kQ3kI
	VSD+gW9ExZcDTp2brIVXDc7Sco99LL/jR6Ep/5wXPEq0QPDWoPr00LB7gn1Zc/6GGiLCVgm1tpA
	sTGlmEsShkn0ve8wJ//NDdToIoHwJ/EfR7KIco86NpFOEnmcFWlfGTeB9aLaaDwgtf1NJJNFBG5
	jxs8Qg7gdQop1Y8UJQhOk9XhiDoBfbhaki2oL1m+sYHRdf2L8sEsU1lEBa0DV84VIjPFRdb854T
	rw==
X-Google-Smtp-Source: AGHT+IF9/STffMSBQKErcBedEUh6zKFT5Jka/X26MYZ0WE84p6+GsFHddD/jpgfjAq683bXrYLKlgA==
X-Received: by 2002:a05:6214:2467:b0:6e6:591b:fa62 with SMTP id 6a1803df08f44-6e6b002ee97mr205009756d6.5.1740443948849;
        Mon, 24 Feb 2025 16:39:08 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c23c34f611sm40101285a.116.2025.02.24.16.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 16:39:08 -0800 (PST)
Date: Tue, 25 Feb 2025 08:38:49 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Chen Wang <unicorn_wang@outlook.com>, 
	Longbin Li <looong.bin@gmail.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
	sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Inochi Amaoto <inochiama@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH 3/3] riscv: dts: sophgo: add Sophgo SPI NOR controller
 driver
Message-ID: <nni37727545uwmq5uizihptcyq435wopjurdjcqufsfvfq3lc3@aq4zpb2l3nw7>
References: <20250224101213.26003-1-looong.bin@gmail.com>
 <20250224101213.26003-4-looong.bin@gmail.com>
 <PN0PR01MB91662EB902D8B337A0526458FEC32@PN0PR01MB9166.INDPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PN0PR01MB91662EB902D8B337A0526458FEC32@PN0PR01MB9166.INDPRD01.PROD.OUTLOOK.COM>

On Tue, Feb 25, 2025 at 08:23:36AM +0800, Chen Wang wrote:
> 
> On 2025/2/24 18:12, Longbin Li wrote:
> > Add SPI NOR device node for Sophgo.
> > 
> > Signed-off-by: Longbin Li <looong.bin@gmail.com>
> > ---
> >   .../boot/dts/sophgo/sg2044-sophgo-sd3-10.dts  | 18 ++++++++++++++
> >   arch/riscv/boot/dts/sophgo/sg2044.dtsi        | 24 +++++++++++++++++++
> >   2 files changed, 42 insertions(+)
> > 
> > diff --git a/arch/riscv/boot/dts/sophgo/sg2044-sophgo-sd3-10.dts b/arch/riscv/boot/dts/sophgo/sg2044-sophgo-sd3-10.dts
> > index c50e61a50013..9c634920f37e 100644
> > --- a/arch/riscv/boot/dts/sophgo/sg2044-sophgo-sd3-10.dts
> > +++ b/arch/riscv/boot/dts/sophgo/sg2044-sophgo-sd3-10.dts
> > @@ -80,6 +80,24 @@ &sd {
> >   	status = "okay";
> >   };
> > 
> > +&spifmc0 {
> > +	status = "okay";
> > +
> > +	flash@0 {
> > +		compatible = "jedec,spi-nor";
> > +		reg = <0>;
> > +	};
> > +};
> > +
> > +&spifmc1 {
> > +	status = "okay";
> > +
> > +	flash@0 {
> > +		compatible = "jedec,spi-nor";
> > +		reg = <0>;
> > +	};
> > +};
> > +
> >   &uart1 {
> >   	status = "okay";
> >   };
> 
> What is your baseline? I can't see "sg2044-sophgo-sd3-10.dts " on the latest
> mainline yet.
> 

It seems like he forgot to remove this patch as the baseline is not
submitted.

> BTW,  the name "sg2044-sophgo-sd3-10" seems a bit redundant. Wouldn't
> "sg2044-sd3-10" be better?
> 

I do not think so. we want <soc-vendor-board> format. In this format.
sophgo is a must.

Regards,
Inochi


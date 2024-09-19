Return-Path: <linux-spi+bounces-4879-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9EE97C832
	for <lists+linux-spi@lfdr.de>; Thu, 19 Sep 2024 12:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AD5828A49E
	for <lists+linux-spi@lfdr.de>; Thu, 19 Sep 2024 10:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B17816D30B;
	Thu, 19 Sep 2024 10:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKcJ/Gf4"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E531360B8A;
	Thu, 19 Sep 2024 10:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726742884; cv=none; b=tNya3Vlp0GYkX/TABmhBUJRvxriDR5RED6LaHNJcqPsFa9sxrnKRsi+Z9iQBHGTKetZ6ps8YXkud9z2Tf+39Wq4zfB8BTc0hDLc2wvQWwXRdpXl26QTaEjSSZHd9GkzsJSHcxjKtH9oXARGA4N4H6uyV1MWkOTa1FnGH8Lm0W60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726742884; c=relaxed/simple;
	bh=ohLG7pnJOBzWUsJJjQmTQwDuGH6In+YAyaFt0MuX6Q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KUtfqNKf1T+ggA4op/ASM+byaK0iYlg4tla+XJBINPp3J7UpMAe3ef7EoxH3CHzu5XmVNhc0FrpVAM/iID1q4ryuP6/7JsuBEVN4cVhTAzBvAHKdY04QAdr2ELzAC+mSq2sH62sKCcJDPlNM5Q/HRpGHfPqt2i8aTR+ksQlZMVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKcJ/Gf4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7418C4CEC4;
	Thu, 19 Sep 2024 10:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726742883;
	bh=ohLG7pnJOBzWUsJJjQmTQwDuGH6In+YAyaFt0MuX6Q4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RKcJ/Gf4eZavVRqqjIrZHbFRa9oSXiUZlBojrI7QB36gQdbsJ7R2OUVFFgzT0vR4K
	 5WGsrUz8cbc3mXxz/OqXejTln8ga/sBJmPpc4CVAQ6qDG1+DsPi4/fqH0J7aIK109F
	 6sDicpXfNFdz3o61ssgZpzXkeiyeXI5divnlxZt2BAXbcvPjzIOBxLwXqc3zbdBwuR
	 1dQJyGuz0yIYa84IifFqV2MmRFlORse4wdXNkUG6m1lAdHrwONTztz7mmb/Eoq7/36
	 4wOTxVDA/0rWqqG1oBX2DWu9iYQSam9Ssm3t35Z5EwqnFjpC1VCE76ew4O2u21Ep0+
	 j2TmK4tDTZCww==
Date: Thu, 19 Sep 2024 12:47:54 +0200
From: Mark Brown <broonie@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: xiaoning.wang@nxp.com, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: spi-fsl-lpspi: Use IRQF_NO_AUTOEN flag in
 request_irq()
Message-ID: <ZuwBWofLJ3ZbKpi8@finisterre.sirena.org.uk>
References: <20240906022828.891812-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z92KKWU5rX8ihNCm"
Content-Disposition: inline
In-Reply-To: <20240906022828.891812-1-ruanjinjie@huawei.com>
X-Cookie: Editing is a rewording activity.


--z92KKWU5rX8ihNCm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 06, 2024 at 10:28:28AM +0800, Jinjie Ruan wrote:
> disable_irq() after request_irq() still has a time gap in which
> interrupts can come. request_irq() with IRQF_NO_AUTOEN flag will
> disable IRQ auto-enable when request IRQ.

> @@ -948,14 +948,10 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
>  	ret = fsl_lpspi_dma_init(&pdev->dev, fsl_lpspi, controller);
>  	if (ret == -EPROBE_DEFER)
>  		goto out_pm_get;
> -	if (ret < 0)
> +	if (ret < 0) {
>  		dev_warn(&pdev->dev, "dma setup error %d, use pio\n", ret);
> -	else
> -		/*
> -		 * disable LPSPI module IRQ when enable DMA mode successfully,
> -		 * to prevent the unexpected LPSPI module IRQ events.
> -		 */
> -		disable_irq(irq);
> +		enable_irq(irq);
> +	}

This now enabled the interrupt in the case where we previously would've
disabled it - I would have expected the condition on the if statement to
be reversed?

--z92KKWU5rX8ihNCm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbsAVkACgkQJNaLcl1U
h9AUJQf/Zs36TMY0LjVstuctLBxIb0D369u7gv3ryDxJVaC8Y5UHDHm5W+sj3Lts
06mKz4OH4hW+/i96l2kKOu4hKYP6huyKSex62oINDo1262FZtu2pueeEmra3aJX0
xpJfw59W7eVnKi6rcWwbrpkTin2J82BV487WamIm71wSvvK0O2rz/ugAQZVYED86
2uU1XnRRIvpcsrwt5kAJhbTK8KcxFuJKK763Q3pgAuUB4zKQck28sIjzb1VPQ1Cd
Jpf3BS5eZe8s4pKchYEd/8XasIqGoetnBhRckbsw7DgDUERUlOskjU0ReykQrpuz
gCm/GdRiC19YoUpNNmzbDRjUKBPy6Q==
=0Ptj
-----END PGP SIGNATURE-----

--z92KKWU5rX8ihNCm--


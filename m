Return-Path: <linux-spi+bounces-7052-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2E0A545AC
	for <lists+linux-spi@lfdr.de>; Thu,  6 Mar 2025 09:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7FF418833B8
	for <lists+linux-spi@lfdr.de>; Thu,  6 Mar 2025 08:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C638C2080DA;
	Thu,  6 Mar 2025 08:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cCBzjB3i"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB3C19D880;
	Thu,  6 Mar 2025 08:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741251548; cv=none; b=e80Ab2EZbTQMfNfrT0iHRr7ms7DLop5GVogC3FekQ9VFfUQOv++9ExeIuRvxrFNPVte2lW0eRv9W34nq5Z30QF0KppWzKsLl4Wg+zR2H3ZzliHUOqxl5lWDeSwrNNxcCpPA91W4dKKAO0VCGKrHd5+wJC/vQUBG7Vn2R7tgiIc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741251548; c=relaxed/simple;
	bh=7afTJcSkXdN+IE3Z0j2vXlLxFn4CzdNno9ZzAKaoSDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=liexrhziK4Z6YHeIDGULkw1OC2ceOE/0RXXeAFdNxi9MWFJAEYJ67Up73/Ecplh44D48GOIIS7z4UdzG8js5xrvhjbmZtBWvXUYZgS6rAoECdTQy1M5/QbAD5PPSUniqR4zw9+5xAdFoYo3ydyHSLrIkA4upHIoFAkzE4pTYHXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cCBzjB3i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17704C4CEE2;
	Thu,  6 Mar 2025 08:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741251548;
	bh=7afTJcSkXdN+IE3Z0j2vXlLxFn4CzdNno9ZzAKaoSDA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cCBzjB3iQBfU8FGGKQz6jXuzV/+/NDtQe61AYBMGARWlO8C0qyjGaOCV/hWRPzS7l
	 TAl7B4gFNoqrJbNoaa9RzgJmP/Q5yb9qNnMIg0vOIpKII4sQ0kb2m0pn8EkynMRvMm
	 ezvBg0vVGoPQDNwc2KCpPI+GTg5WR89RGclnNXkIB6hp7zgU6OWKuUVB8sZBHEvCu/
	 mvh/3wp2iSHz1GXeCQ4u72LMyNHca4phaZEaHtVcbS0TfaiWYkhevTpvUo4Yt12xRC
	 yaSpKgIc4tB0gdUsQIE9uddtEuhaDC+HstHwmeH00ee5H0VCsR++t2nkSvs1dQB7sN
	 4KU7mA63atRzg==
Date: Thu, 6 Mar 2025 09:59:03 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, Vaishnav Achath <vaishnav.a@ti.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 3/3] spi: dt-bindings: cdns,qspi-nor: Make the example
 real
Message-ID: <20250306-crystal-elk-of-superiority-e783ac@krzk-bin>
References: <20250305200133.2511308-1-miquel.raynal@bootlin.com>
 <20250305200133.2511308-4-miquel.raynal@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250305200133.2511308-4-miquel.raynal@bootlin.com>

On Wed, Mar 05, 2025 at 09:01:33PM +0100, Miquel Raynal wrote:
> Add several properties to the example. They are actually mandatory from
> a description point of view. Unfortunately, because of some YAML
> limitations, they are just listed in a file showing the peripheral
> properties that "can" be used for this specific controller without
> marking them "required" explicitly.

You can mark them as required - in this binding. See exynos-srom.yaml
(I fixed missing ref to mc-peripheral-props in separate patch).

> 
> At least mention these properties in the example to hint people they
> exist.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Best regards,
Krzysztof



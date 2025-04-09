Return-Path: <linux-spi+bounces-7479-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD2CA81E78
	for <lists+linux-spi@lfdr.de>; Wed,  9 Apr 2025 09:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 693974A4F1C
	for <lists+linux-spi@lfdr.de>; Wed,  9 Apr 2025 07:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5399825A324;
	Wed,  9 Apr 2025 07:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADbsarn1"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F96F2AE89;
	Wed,  9 Apr 2025 07:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744184502; cv=none; b=VEvIrUvYpRKR8ukwgK5VuAwwuJXPVf5JAGm4MVCclHVMWTUfihEByYrhGrlwjiL0HooPXVDspYnnH5BjwaajdzvceLRBBzqfdzNg/VjbCszKX/+VoOw4SHNVeZDf/V9Nls/do1YtwDzf2ijYXRqhV0EGnfnT5aGPBUn++HuWZ1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744184502; c=relaxed/simple;
	bh=b5ZWJSt98bGlYQWhOR/2hFH9QvIVdwmraGsAqX/dums=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eF7yw96ypehCIjettwWqGkKVjj9uACEVlyWSFz2tQ37mvgqIE2N1yFg46TfvroVVgEuPZ7gKpbNU0XRt5HByridpFDzpuAdTAWGnNqbXBCq/W5ueX5JZuAFINWabNyMoAerbRL39m4INwHFg1rzQinUMDAY7OMHbT9ebinSAJ2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADbsarn1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECEEEC4CEE3;
	Wed,  9 Apr 2025 07:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744184501;
	bh=b5ZWJSt98bGlYQWhOR/2hFH9QvIVdwmraGsAqX/dums=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=ADbsarn1KqN8k1Ns2zG9iXspz0IShp20rQDARlqE9IiRqUJLImpzauuNFW4iyW5Nz
	 XXIkD9Xj9XcVPpZVRxUz0jnI12XTZo4zujSekJOYzwPT8tV32VNjseLhWBPZ6K5RUb
	 ipt3WDlVpkIzMb9GQHGm/PbHK/XFn1MA+YBYJUBw6fcIfYofYMJeoOVa0S4dwnWRHH
	 Ts92imvf3Y2SHArfq4pQEw18xc80S5CWyWZ6zhNWN5lv+5pElZbRYqCwE8HABvd+6m
	 e1mvflcIbWEChE70GwKrhzvz0SDgm/QeD6wUe0+6uS+xaBcfFPUEhFTNtI1ZH8afbN
	 TeZLP9MfGXg0g==
Date: Wed, 9 Apr 2025 09:41:38 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
	Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Jaroslav Kysela <perex@perex.cz>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 5/7] ASoC: renesas: add MSIOF sound Documentation
Message-ID: <20250409-mouse-of-eternal-warranty-5eafd2@shite>
References: <875xjeb0wu.wl-kuninori.morimoto.gx@renesas.com>
 <87y0wa9mb2.wl-kuninori.morimoto.gx@renesas.com>
 <bd15c145-c175-468d-a1ac-1ad157358aea@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bd15c145-c175-468d-a1ac-1ad157358aea@kernel.org>

On Wed, Apr 09, 2025 at 08:37:03AM GMT, Krzysztof Kozlowski wrote:
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - const: renesas,msiof-r8a779g0   # R-Car V4H
> 
> 
> Use expected format of all soc compatibles. It has been always: SoC-module.

... unless this is an existing compatible, but then it should be in one
schema, not two.

Best regards,
Krzysztof



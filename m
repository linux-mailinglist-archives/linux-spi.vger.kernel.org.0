Return-Path: <linux-spi+bounces-11106-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FE7C3EE33
	for <lists+linux-spi@lfdr.de>; Fri, 07 Nov 2025 09:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FDA91889171
	for <lists+linux-spi@lfdr.de>; Fri,  7 Nov 2025 08:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE8330F812;
	Fri,  7 Nov 2025 08:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPN4lvNk"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC3230F555;
	Fri,  7 Nov 2025 08:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762502959; cv=none; b=m51tDomnCBF8y0t4bqX3VOLlmUBW3c+CLNcDbfKctBNcyHwpftTqdvC1WhQCwzSPF8aUGG6LCkqO6WK+igmOXkIhf5+1rPFOQTuP+fUzv/YhtnpKfETfr7ZxjK6EKVckZMgEl9EzN3sG/Jv3YfhZ0yi4I+rsL8q158FhFUrudcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762502959; c=relaxed/simple;
	bh=SHkgT4O0QYZQESnYkYA3hFJiRwM0MhkBqOpCwK69q74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hljIj1FFbhIzL4WYXFjE7QMZ7aEnaVuhY9uIgyDybAVOA0jDsWo82vR+/53WaHtS1B0HNNK8BQzsV6OdeNi8VoWGedA0wWjTmDNoLARvt3iw+WF70lxPfs7oULd9XfZjF+ZiumVdD/6TbslBfuPkwbts4Vc/RaewqpbL3TYhJ3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPN4lvNk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C4F2C116B1;
	Fri,  7 Nov 2025 08:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762502958;
	bh=SHkgT4O0QYZQESnYkYA3hFJiRwM0MhkBqOpCwK69q74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MPN4lvNkt4HzKR83woEdZjIXw+mMBiJP2u/oqIxs/uEOtiUWED01o26SOiaORPwLV
	 zy66HKPkAJ6SEjjVJ5uMc/0+FhRKe4h+A9C937PAAnPZ7PNvLz5imEFANEnwHeS8pz
	 1BPRqL8UVxzEalkiqPbA+Dpp8QDZM0zfEwWlV3G20mF2NJuapzIRC3ScgpTuicUx+2
	 9MeEQtVUdC3W8bxDK1ycJA3/uRppd8Gu0F75TSjegmXR8xOI8VzM9HsA+f6W85SqvS
	 CEI2F+QfS3f9/ec70Zu43me0QIDJ1thC5267lnmoNOLmWww1cusVe7ML3nHeu3kZ9k
	 tj6uvpY76ZBVw==
Date: Fri, 7 Nov 2025 09:09:15 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Riccardo Mereu <r.mereu.kernel@arduino.cc>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, broonie@kernel.org, linux@roeck-us.net, 
	Jonathan.Cameron@huawei.com, wenswang@yeah.net, naresh.solanki@9elements.com, 
	michal.simek@amd.com, nuno.sa@analog.com, chou.cosmo@gmail.com, 
	grantpeltier93@gmail.com, eajames@linux.ibm.com, farouk.bouabid@cherry.de, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-spi@vger.kernel.org, mm.facchin@arduino.cc, Riccardo Mereu <r.mereu@arduino.cc>
Subject: Re: [PATCH 1/5] dt-binding: trivial-devices: add arduino spi mcu
 interface
Message-ID: <20251107-independent-barnacle-of-examination-684fbb@kuoka>
References: <20251106153119.266840-1-r.mereu@arduino.cc>
 <20251106153119.266840-2-r.mereu@arduino.cc>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251106153119.266840-2-r.mereu@arduino.cc>

On Thu, Nov 06, 2025 at 04:31:15PM +0100, Riccardo Mereu wrote:
> Add spidev item in order to describe in Arduino boards one of the
> interfaces between microprocessor and microcontroller.
> 
> Signed-off-by: Riccardo Mereu <r.mereu@arduino.cc>

Also, now I see warnings, so standard message:

Please run scripts/checkpatch.pl on the patches and fix reported
warnings. After that, run also 'scripts/checkpatch.pl --strict' on the
patches and (probably) fix more warnings. Some warnings can be ignored,
especially from --strict run, but the code here looks like it needs a
fix. Feel free to get in touch if the warning is not clear.

Best regards,
Krzysztof



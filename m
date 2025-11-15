Return-Path: <linux-spi+bounces-11232-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB6FC60409
	for <lists+linux-spi@lfdr.de>; Sat, 15 Nov 2025 12:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5739B3B9903
	for <lists+linux-spi@lfdr.de>; Sat, 15 Nov 2025 11:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B9C28CF42;
	Sat, 15 Nov 2025 11:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="awKbxM2u"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCA8E571;
	Sat, 15 Nov 2025 11:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763206581; cv=none; b=bsLQPi0Sm8Idn8mIxZCXHeIDIcAZALijgBdebEwsI9b1Jm3QDxNujZ6rXxFat18LMLQ5GmtDcX3BJ6GToHz0oKeGaDLKa7ZGuKrn98LCNZhHCsAMmDd5ANqEJ/Jgp+paLrwwa/SM8RPATAoZkVUpTh1jKFlwkikw3A9IyX8yTc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763206581; c=relaxed/simple;
	bh=8CcSefcJ7/USdqH95R2OF8imCLNtg1E6NSwIBz3mQ+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rIcYP7KJq2HBWSs30BZzFBSpEgw44qVJI1AvnKVqHng7qtsF6bOwoJZWIuW9OqDDuURZxCh5m1yV5cTT8XeBazTYy2Mt/pFnyh/II59qePNnlUyjsdE9IoT+rqaqR62XBIoz63HyHT2zTYKRKjc8KrrnWp7HVzcqLOA2Qkx8uJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=awKbxM2u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6707C4CEF8;
	Sat, 15 Nov 2025 11:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763206580;
	bh=8CcSefcJ7/USdqH95R2OF8imCLNtg1E6NSwIBz3mQ+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=awKbxM2ukkwq+RWQp3uQ3uyUfoGEYP4KK7nWOi6IvaRY8Po6CNR+/7c5aJXM69b7E
	 kUITrO0muJst2xm/9j3IDoHXRNd75Tr0+i74dqelW+U3/k9HVDIZM3eqgF0hiDlbSS
	 pJFyCox60nlIAC/tZZm+v3uF/YKKJhQ7aow3ookIZ7EOmuBqyGeobLRtZZYLAO1qY8
	 CZuMHgxlteQVPxw6gT71qAXhzY8nNZ+Z2REsdM7mq27nSyIDW/YegZRfBYyw/jP2UT
	 +/cXVu3yWqzBkDyAE8/1FIVMn7b9T7q2tF/XPIHtCBJdW01qDBqH3F/TOloHNezKYj
	 K837iELNiSjNA==
Date: Sat, 15 Nov 2025 12:36:17 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Riccardo Mereu <r.mereu.kernel@arduino.cc>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, broonie@kernel.org, linux@roeck-us.net, 
	Jonathan.Cameron@huawei.com, wenswang@yeah.net, naresh.solanki@9elements.com, 
	michal.simek@amd.com, nuno.sa@analog.com, chou.cosmo@gmail.com, 
	grantpeltier93@gmail.com, eajames@linux.ibm.com, farouk.bouabid@cherry.de, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-spi@vger.kernel.org, m.facchin@arduino.cc, Riccardo Mereu <r.mereu@arduino.cc>
Subject: Re: [PATCH v2 1/6] dt-bindings: vendor-prefixes: Add Arduino name
Message-ID: <20251115-spiked-hypersonic-chamois-e94fee@kuoka>
References: <20251114121853.16472-1-r.mereu@arduino.cc>
 <20251114121853.16472-2-r.mereu@arduino.cc>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251114121853.16472-2-r.mereu@arduino.cc>

On Fri, Nov 14, 2025 at 01:18:48PM +0100, Riccardo Mereu wrote:
> Add entry for Arduino Srl (https://arduino.cc)
> 
> Signed-off-by: Riccardo Mereu <r.mereu@arduino.cc>

You have checkpatch warnings.

Best regards,
Krzysztof



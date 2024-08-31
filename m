Return-Path: <linux-spi+bounces-4496-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7272496732F
	for <lists+linux-spi@lfdr.de>; Sat, 31 Aug 2024 21:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D64671F21FAB
	for <lists+linux-spi@lfdr.de>; Sat, 31 Aug 2024 19:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C33313CFBC;
	Sat, 31 Aug 2024 19:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZJOxOjm"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8722A50;
	Sat, 31 Aug 2024 19:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725134340; cv=none; b=m9keDBdBSdtXTJfkIGt9YADL4pqUopylBmeAxOCcNn4O85+AqZ0mW0shHkh3uE3vlz4sslGmAPE3/15j0whnWDJhXz8q6rKsADVvliZSzvmeeF45SFQlwPgOP1oc5kwZFUVVd8tDSu42jQKOTFLS7V+HgUNcCOaK77unDJ2CGa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725134340; c=relaxed/simple;
	bh=hcTvMs84/N32OXLzqfp+GuUm4tSKmhWMDx24u0Q+SJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZL30Sw8+oEx/5xv0EcEWw6ZhYkv9ETB9WZl8qJjB/5JX6zFEhYyZnmqSgqzie5VbxqnmCglZTy2MeXWL40Q+y4QVigjHkuDYEnpGocVrgI6OyKTE+y/tZ0hU4otTYzvzqbiuiPXJ+X9z577qwwFHDu12057bjtCASF2Cc6vUZnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZJOxOjm; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5344ab30508so3769465e87.0;
        Sat, 31 Aug 2024 12:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725134337; x=1725739137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ZHCdpJQwEFQKiIyr8y63bvNgPTxzMuReRIYhn8ikn0=;
        b=JZJOxOjmUlKQEKzYtFwFJj/SmDymLIhmOQsfx69/6njs3Rh6cbeZ3wqY2QlBxei8P0
         nKoznXTWmTi7dRUh7yujqOM1zjNlhF1OryZ6JE6fC5Aa8asaFmviZQaC8EUq5yJw3FsD
         xecI5PWJkH4ehlfun60Vpju4YRG+5RlvoStc+uEi8xrPC3KZKWa606UAFFkRp3rUCbNo
         F/Q54td8OwvvZzfVud994WGPsh3dbFW24EUWo6Lgc00vyfe09e8tRxcw9C7/eV521iTe
         +WM8TOh2F3ZOJQEeDozDlzd8fqspET3O71Y91q1Z0BAi2fJV3JjfdilD7/OXDIPKIPDf
         UpCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725134337; x=1725739137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ZHCdpJQwEFQKiIyr8y63bvNgPTxzMuReRIYhn8ikn0=;
        b=heuSfa1VEIiCOr6YpP70Ds9aNFKLzad6LcyJloE7Dp0gnMZBuE+NHMwGJAOGIM+LC2
         teG8zk+ilf98HC/nCUlyqUW1Tu8oVTN1XC2XQE1bVZOJK3BivLpsJER6aoj2wDzKUA5O
         SAjmijhXhC17DmYWXj/O+jS64eDkuQkXETN8AMJUmFLvSu9WGJMv6ZRHCxHoyejkSAsK
         EIq7p73njRseYe8dz1OL+Z7MMxTWFotT5l+WhvOsoW3y0606A12Jc/nRAeMxwwueDXIp
         wYgdYKu8Hn0Pux+YE6kAzVOYfV/OsZdyQAQJJu+h6lkW5UyMNZZZf/DXU8q/Sn9vAFRG
         d+Bw==
X-Forwarded-Encrypted: i=1; AJvYcCWLNn+vq3KIXaMApqsdcvQwnIe9rOx7UImJ+dtWIxdpuqumoOqMeNN89sYEmyiw9xlh/TJjw3gIwW8A@vger.kernel.org, AJvYcCX2/WFe+DwMlE7KWWiUtG7uUhBR6XDjHwHLDZFMW0XbKXf+fKDiEeveL+XJBs3lKmnIksypn4PPw+K+@vger.kernel.org
X-Gm-Message-State: AOJu0YyqC+LODCIdWrhZujJre/epEBJmVHuSFiqHdJ4yw7dvjsxXcOGM
	j3RDl8UhoauFM3+kuB0xusiF719a7xNnnISftMrgozgKL8tLgBYkAqgRlspQw9fvBZkPtY3oUo4
	1/nIWlWx70fbIugOVG6Lg7ZhL4Ts=
X-Google-Smtp-Source: AGHT+IG669zxMjs/bVB7yuskJp/yxqRbc5PPWx9qQYwSU+sLZ6nyVL/x0xcqjQfMU35Teo1NN+W+Iis9MVoVfVHGlQU=
X-Received: by 2002:a05:6512:a87:b0:533:32cf:6420 with SMTP id
 2adb3069b0e04-535462f71bemr2020620e87.8.1725134336712; Sat, 31 Aug 2024
 12:58:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830171849.3750165-1-festevam@gmail.com> <cyjfrkrszis2ye6vbuasblze4ufesk3wagfwrva6ljv4yfxnxc@2sqin2agzmle>
In-Reply-To: <cyjfrkrszis2ye6vbuasblze4ufesk3wagfwrva6ljv4yfxnxc@2sqin2agzmle>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 31 Aug 2024 16:58:45 -0300
Message-ID: <CAOMZO5BH=fRdQ6vg9wjhWNnwt699bSx+MsUwhJwmq6B5CCU3xA@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: trivial-devices: Document spi-cpha and spi-cpol
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: broonie@kernel.org, linux-spi@vger.kernel.org, 
	otavio.salvador@ossystems.com.br, heiko@sntech.de, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

On Sat, Aug 31, 2024 at 3:23=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:

> No, this does not look correct. Why suddenly all devices get CPHA/CPOL?
> This is supposed to be only for devices REALLY needing it (as discussed
> with patch moving it out of spi-peripheral-props, did anything change
> here?).

I tried like to apply spi-cpha and spi-cpol only to elgin,jg10309-01:

--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -419,6 +419,17 @@ properties:
           - vicor,pli1209bc
             # Winbond/Nuvoton H/W Monitor
           - winbond,w83793
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - elgin,jg10309-01
+    then:
+      properties:
+        spi-cpha: true
+        spi-cpol: true

 required:
   - compatible

but that did not help:

$ make CHECK_DTBS=3Dy rockchip/rv1108-elgin-r1.dtb -j12

  DTC [C] arch/arm/boot/dts/rockchip/rv1108-elgin-r1.dtb
/home/fabio/linux-next/arch/arm/boot/dts/rockchip/rv1108-elgin-r1.dtb:
display@0: 'spi-cpha', 'spi-cpol' do not match any of the regexes:
'pinctrl-[0-9]+'
from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#

I would appreciate a suggestion on how to fix the warning.

Thanks


Return-Path: <linux-spi+bounces-4765-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BA6973AD8
	for <lists+linux-spi@lfdr.de>; Tue, 10 Sep 2024 17:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E36F1C253A0
	for <lists+linux-spi@lfdr.de>; Tue, 10 Sep 2024 15:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B115A199936;
	Tue, 10 Sep 2024 15:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQLH64F7"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACBB6F305;
	Tue, 10 Sep 2024 15:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725980552; cv=none; b=NTez9GrisEFlW3Ri353cQuvow5ZxCiDb777Ll2EgAynpC+6ml8BMMIEyf2IeOly3Rv2y6ExXlMN6vrO3xXUesQwjfaAodqnIbPBhWNA2Fw3lf6SR8zJMNtQpRFqecZAa9OPxYi8N3vegx9XZhdwbz6yyU0RH1rg/joodTsyVJlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725980552; c=relaxed/simple;
	bh=W6ZXK4BqIQ5sZPTV//jiyQeTy+WpFTrkrTJvXNKvSV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FffROEVJHh/92499wUWRopc8jdQhR7SRNHp+wxSuv25zMnAe8sNF6M7srhYUjgXW1rgSOFydeazBjguKYI/9e6AorJRzh4TSCho0qhyqbclxoctDtFZrm99gfP7F7SP3xOh93tw1pDE0soMnc7nZy/XinoPtQAE5sw4UnPKt/3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQLH64F7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 016DFC4CEDC;
	Tue, 10 Sep 2024 15:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725980551;
	bh=W6ZXK4BqIQ5sZPTV//jiyQeTy+WpFTrkrTJvXNKvSV4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WQLH64F7Kdm/KeMLAVV1ZHWQ4WdSMsoGNjIUb2QQH8z5FWxcxrAWc3SWbx5Y8YLku
	 p7t5h1fsXSQ/aBbhYp6L6N/F1Um/GkXxZd8hGEF7hcDn5I4VJTv9OIYEsP1+qikbf1
	 a+p7IS0hXW5+v1ph1GRGCuQB3xEdTchY/gVxY+OU7H5c1pQRZRT5okzPlYJxsjBFly
	 cwrmYytFAKM42ASKOfviY4dPdZRAy+G7jod+1iQzaHNi+qlfMX/sYnvFN1qU+B+E5D
	 oKVDNkmSI4v65mmoa6GQ7LYpDWvns/yg0DeyU7lnNhYTIINrQ2u+6f34VlbtuiW0YY
	 y4UDACjRG/LCQ==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f75e5f3debso30743601fa.1;
        Tue, 10 Sep 2024 08:02:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU+o4chHomT5o8EDq72RKFmROLfPzd30uQoapMfL1gpJTHLBsfmLnrJCZ+3UoGRRb/Bw5xcyqGWmJld@vger.kernel.org, AJvYcCVYnZ6+AdpQvA/EU7NtU3WlblFLKO/10JGiyeGWZR+6lIUOmGpd7E0QNIkt0d1BNV9glDlgdOTYU45B@vger.kernel.org
X-Gm-Message-State: AOJu0Yy76sKLTi2woZovCIF0G41i3VJyPEyX8daLxaNKDpea0tALpunc
	7cvtqt4pYcPmp/HCca0K8r0Lt3uIy1O8J4QgtOBRK+oLmjZUyZLXlmxsGJSF11n9s/Xqs+xONHT
	KhkehS4JQX28IUqKWNDzTQKNzgg==
X-Google-Smtp-Source: AGHT+IE0YPwWDcHN8VPPd0NLSKnucIR0S03aYVklYCw0SlGmLiMd7QSmOfdqpkHQY/heuP9Sq92aIZ6E6H/0ivzO0kU=
X-Received: by 2002:a05:6512:ba0:b0:534:53ce:5483 with SMTP id
 2adb3069b0e04-536587c95a5mr10306511e87.35.1725980549342; Tue, 10 Sep 2024
 08:02:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830171849.3750165-1-festevam@gmail.com> <cyjfrkrszis2ye6vbuasblze4ufesk3wagfwrva6ljv4yfxnxc@2sqin2agzmle>
 <CAOMZO5BH=fRdQ6vg9wjhWNnwt699bSx+MsUwhJwmq6B5CCU3xA@mail.gmail.com> <605836ad-d1d6-448a-b963-89d758cb24b3@kernel.org>
In-Reply-To: <605836ad-d1d6-448a-b963-89d758cb24b3@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Tue, 10 Sep 2024 10:02:17 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKW=oQMHLT0ydyGRPb89qDTBKc1=bnDQ1=oboKez98o3A@mail.gmail.com>
Message-ID: <CAL_JsqKW=oQMHLT0ydyGRPb89qDTBKc1=bnDQ1=oboKez98o3A@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: trivial-devices: Document spi-cpha and spi-cpol
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Fabio Estevam <festevam@gmail.com>, broonie@kernel.org, linux-spi@vger.kernel.org, 
	otavio.salvador@ossystems.com.br, heiko@sntech.de, krzk+dt@kernel.org, 
	conor+dt@kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 1, 2024 at 5:24=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On 31/08/2024 21:58, Fabio Estevam wrote:
> > Hi Krzysztof,
> >
> > On Sat, Aug 31, 2024 at 3:23=E2=80=AFAM Krzysztof Kozlowski <krzk@kerne=
l.org> wrote:
> >
> >> No, this does not look correct. Why suddenly all devices get CPHA/CPOL=
?
> >> This is supposed to be only for devices REALLY needing it (as discusse=
d
> >> with patch moving it out of spi-peripheral-props, did anything change
> >> here?).
> >
> > I tried like to apply spi-cpha and spi-cpol only to elgin,jg10309-01:
> >
>
> I think the device should be moved out of trivial devices to its own
> schema. However wait for feedback from Rob, because he proposed this
> patch here.

Okay, let's do a separate schema.

Rob


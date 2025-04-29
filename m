Return-Path: <linux-spi+bounces-7798-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B9CAA0944
	for <lists+linux-spi@lfdr.de>; Tue, 29 Apr 2025 13:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7870F171FCF
	for <lists+linux-spi@lfdr.de>; Tue, 29 Apr 2025 11:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818272C1089;
	Tue, 29 Apr 2025 11:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJoNtR21"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DAA1E766F;
	Tue, 29 Apr 2025 11:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745924944; cv=none; b=MBDkaIBxHtL6JnsJBaeNf6UaLbzU48AWxlhhU66+YJ2n9n0c6yG8V98bBCFqKvoRuz/LBZSjXbAvMFYX8mSNlCIARdWMiujjMJey7opeJwNdSubaBpH77S8fWM1SZvnDc1isk+iBhsrXwREtS7Lc09IvH+AMsTXJdXSiyBccL40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745924944; c=relaxed/simple;
	bh=6W5bZ7kV+SEAo1aKDYzV8iQ9Oc96d7635w7XhaN2yN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FGu4VDmrytwEsR2HqvbA4TMvZJTW+TYlaM/gKXpklfrU0xkcZFA+DJAL5WXHxUI/91cOngSfggMxf5LiYoclYxpi+Y1biuzwORtz0vyAwdz+mNhShdr9SSMTRe7/AEMy+CRxSRZe5Tb6VP6mDVV75Osx0SYUHPF/ai61KxYK9/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJoNtR21; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0FECC4AF0C;
	Tue, 29 Apr 2025 11:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745924943;
	bh=6W5bZ7kV+SEAo1aKDYzV8iQ9Oc96d7635w7XhaN2yN0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kJoNtR21vvtiSK5I4AhujhMcNV+jG3JNu8FI7oxh5yfbV+ZGNOJAcf70SZ6ZSbSSh
	 WBA6V6p0QtkKVHNdfpf78MPtWIqpmwUBJlYJTzrZvhAcslEg+Ok3J8Th6QnSWh8qvV
	 10U4NKBGv5e21OLZCs4VfN9DALwLzye40muCMeiO6cNaIXV7O6k77LyqZA0oBKafXN
	 qVziuIj7I6gsva59f529qRXh9gygYQYEzDjUdqla68igWIwRnbbirGlzXeO2cbCs9r
	 PYgmQ9Ww/z9N3j3sDgyS4MQc7ykvmUy+DCcAa6TahzHBHr9YBfpaSxLoPgOHYximNo
	 7L0asRTv1pDAg==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2da3c5729fcso646430fac.0;
        Tue, 29 Apr 2025 04:09:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUHV1BWex9W/CZ/9MRrEIffWgutpHrgPtD8P1h+dEj+d4O+kaHn1dzYqXjjipIKSigvIfGmVwVZ+8mjq10=@vger.kernel.org, AJvYcCUrGPX+pqDFJPv5is1z9q+cfizHJFIgKuiXKKk0X0u+YT8TmZDOmHOIA9u49UK41KgoQxyK05ydyOU=@vger.kernel.org, AJvYcCWcmwdSjP/HAgry7FvLnBMoWffnohSwJpGsBXfjjNbWYIKRXwxXzVHZbcskzac9AqDJBh7OHEwUSH4T@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7k3Qc2V1mVq9G+g2wWzU7j7iut1GSOJY11TBdd56oBFVUgGkR
	tgj3AVtPDUX0UQ0rRzyqCMuQiDmTR1AthS5pIwBNY145nO+HKJA5iCRGR6oQasoCeOKzs2Wco0n
	Y6TnK2QEFyTkKBwMQXxLAL6a7QWw=
X-Google-Smtp-Source: AGHT+IFY4i+B3pR5hn7A2kqkAlnBnbb/HDJe+RY21qXj4tISAk0tiDxufLtwdDVT//wBwk48KcRpyo3+ep5C+qD0nl0=
X-Received: by 2002:a05:6871:2886:b0:2c3:f8e3:bdb9 with SMTP id
 586e51a60fabf-2da486a7a9amr1047877fac.28.1745924943157; Tue, 29 Apr 2025
 04:09:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250327195928.680771-2-csokas.bence@prolan.hu>
 <20250327195928.680771-3-csokas.bence@prolan.hu> <CAJZ5v0jmuzvo-xzGBDhGVBbY7svbrqEdi-SeJrx5BG=qtN6ZiQ@mail.gmail.com>
 <b38b27d4-c3d3-450c-8634-2e07f393a76c@prolan.hu>
In-Reply-To: <b38b27d4-c3d3-450c-8634-2e07f393a76c@prolan.hu>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 29 Apr 2025 13:08:51 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hRsXw45utNMEhLB=i56tsJDz8AvYfV2stPbtRHh09HUg@mail.gmail.com>
X-Gm-Features: ATxdqUES0FmjmyEqrlOpgBYB8t6ofrTgX8zGFUf5SN2x5tU_vCgg6l81l9wKEDc
Message-ID: <CAJZ5v0hRsXw45utNMEhLB=i56tsJDz8AvYfV2stPbtRHh09HUg@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] pm: runtime: Add new devm functions
To: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Varshini Rajendran <varshini.rajendran@microchip.com>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Len Brown <len.brown@intel.com>, 
	Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, Alexander Dahl <ada@thorsis.com>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Pavel Machek <pavel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 10:44=E2=80=AFAM Cs=C3=B3k=C3=A1s Bence <csokas.ben=
ce@prolan.hu> wrote:
>
> Hi,
>
> On 2025. 04. 09. 19:43, Rafael J. Wysocki wrote:
> > On Thu, Mar 27, 2025 at 8:59=E2=80=AFPM Bence Cs=C3=B3k=C3=A1s <csokas.=
bence@prolan.hu> wrote:
> >>
> >> Add `devm_pm_runtime_set_active_enabled()` and
> >> `devm_pm_runtime_get_noresume()` for simplifying common cases in drive=
rs.
> >>
> >> Signed-off-by: Bence Cs=C3=B3k=C3=A1s <csokas.bence@prolan.hu>
> >
> > I can apply this one alone if you want me to do that, but I could also
> > apply the other patch in the series if it got an ACK from the driver
> > maintainer.
>
> Did this end up being applied?

Just applied as 6.16 material, I'll let you know when the tag to pull
from is ready.

Thanks!


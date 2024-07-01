Return-Path: <linux-spi+bounces-3702-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D54191DB95
	for <lists+linux-spi@lfdr.de>; Mon,  1 Jul 2024 11:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FBDF1C21653
	for <lists+linux-spi@lfdr.de>; Mon,  1 Jul 2024 09:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F67C83A18;
	Mon,  1 Jul 2024 09:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="filY6b2w"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D977084E18;
	Mon,  1 Jul 2024 09:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719826590; cv=none; b=VDNeduVhWfQiyzDdEAakRHfDavzZCyr6iJw0e0YXQNlpYcMzspNavgr4U08oHviEERx9UHdBKA1255XJ5JMh7brIalUDBjGH8DuQzit0FlGMjzpy1+QnSzxzc9lAjZMwUnyW54/WKOv23w8O1VNZwpjBrQ69StdVHLad/LjGRR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719826590; c=relaxed/simple;
	bh=x/FaaCNObMQRMVAxnUKHTYi7tmoPZ/zyS4vWlvQC4KU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FI6SLYFRJbJ+utWuaM1sr0Q9tKa3TH4GiZPw9+aNPwTeG6bXF+MgCPt+V15rMif0d0j0b5wUQxrsnSuuCeQNISWnQ+Ffw8Cp0G56/vCXY9AyWReHAvID89Hbd3SLybQePywWbGKQlXZj8yulb1I6GwxqAjyMHo8KK/KeffPYTRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=filY6b2w; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57cc30eaf0aso1553968a12.2;
        Mon, 01 Jul 2024 02:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719826587; x=1720431387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s8NEAicxK5SOO/DpN859XnH2s6bGeotY7ty6AZrfDFk=;
        b=filY6b2wkymlsp1B/M3x+12QBW3E4np2Ul5bUyPvHiMh1bvAiOSCVGBi9IpqQWlYZ/
         Gi7c0sYtCVFBV2/cDxJt1yLQKK2qnXyJcWO9agBZ4SIHKxe51HuuLY/WlPhMKS7pCdp9
         zlWyrk5lQVuM+JaWz9BseBst7OzX2mf5kiKONMvJCEdg1B50CGR1ufldeBnd8pLW/SIV
         zmOGbtFY4CWFrJInr3qWhUEywsd0deuvp+Oofu9d2x1WVBPwsyD9guKxFIacE4gfmbYN
         UA+JP4hMuGks4VXhdG/V2CwFKm7Ss1SxwkSGjHilLwkjbE6ruJGqykQU/pRQ//sNlV9R
         XgcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719826587; x=1720431387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s8NEAicxK5SOO/DpN859XnH2s6bGeotY7ty6AZrfDFk=;
        b=A0JJeJ5NPyP0Bz7dzte+q/X57DeeenuRiMXOdUp+hqk1lYF9EBYmyXfPHE6BmWCqYT
         vksmOTQQNSwsxE7lv2crOi5BeXGAE5YNdUw2mLfXXtrAWqgbLaUf9oMNuuqIGtSJg0Q9
         sY5ZXrs5oHboE2o+au1tKdOefuOIf+bVVtFwbMlQcqvPUdaAyWRK0YqJSE2gIh9DAcwv
         r4RDxdbOw/LcWWM7j/IQ7XG507n1qYfame5Guslk41n0iXBlEiP5eWC2c842z7iq5QFC
         yOEjbE6CI9MVq5KkJMS8zQtMMo/eD6TApaxyCJrf3m0Zbau8iyZF77lZVkcQ8MMSsh06
         wV5g==
X-Forwarded-Encrypted: i=1; AJvYcCWF4b6Khjnnm8OC4GqWFR9aIxAUj/bf1sszWqsOI6erw0/WPEtT5tQmz8ntY7nXJc3ypq7CAMPRmZa1ZewqTAtvpgDvg8pGd05O0HmAYcHzMqwFD03YUtdwpGst83+AjKMgtpUJVTXWGoRxawcHnWkj7Vd2phyNe9mT4S954xWkYvPOhQ==
X-Gm-Message-State: AOJu0YzFTpyYsZqdMxYehLnNoTeeeNO2A4yjVEtOkCX6D8fu8efgfXSj
	yjLjEsxV6TKi1E5ROpanCVC1rOhYGRsVPykiH0ufhEPQbLQ41YmkMcZIMkzjV0mDlh1DNtDGCIY
	KtPayhFPTjzqJul8vrE9j6O8asiA=
X-Google-Smtp-Source: AGHT+IGoFY6xMELK5Ls4bguzayKxots99jk3JnLXJDzSCuJ1vASo+Aoxy+p728spfGMERimeYlOeJBHUIbWS876Fqh0=
X-Received: by 2002:a05:6402:42c8:b0:57c:57b3:8d0e with SMTP id
 4fb4d7f45d1cf-5879f3ac2fcmr4766371a12.11.1719826586918; Mon, 01 Jul 2024
 02:36:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240630063845.116307-1-kanakshilledar@gmail.com>
 <20240630-generous-carnation-c534f5d84a8a@spud> <CAGLn_=vG09C49goRkbygZdYch8H1c_kw3p7ar9NGOrgpd0_MiA@mail.gmail.com>
 <20240701-unsnap-unhitched-a84476a719cd@spud>
In-Reply-To: <20240701-unsnap-unhitched-a84476a719cd@spud>
From: Kanak Shilledar <kanakshilledar@gmail.com>
Date: Mon, 1 Jul 2024 15:06:15 +0530
Message-ID: <CAGLn_=tE91_EEW6tV1aTYJQ7dPSTazjd_tc-t0Q7PJQA2ePYQg@mail.gmail.com>
Subject: Re: [PATCH] arch: riscv: thead: implement basic spi
To: Conor Dooley <conor@kernel.org>
Cc: kanakshilledar111@protonmail.com, Serge Semin <fancer.lancer@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 3:03=E2=80=AFPM Conor Dooley <conor@kernel.org> wrot=
e:
>
> On Mon, Jul 01, 2024 at 02:43:46PM +0530, Kanak Shilledar wrote:
> > On Sun, Jun 30, 2024 at 7:22=E2=80=AFPM Conor Dooley <conor@kernel.org>=
 wrote:
> > >
> > > On Sun, Jun 30, 2024 at 12:08:20PM +0530, Kanak Shilledar wrote:
> > > > implemented basic spi support for TH1520 SoC.
> > > > created a fixed clock and a simple spi0 node.
> > > > updated the matching binding to include thead,th1520-spi as compati=
ble.
> > > > added a spidev device in devicetree which will utilise the spi0 nod=
e.
> > > > this is usually reserved for a SPI NOR flash which is left unpopula=
ted
> > > > underneath the carrier board. I performed a SPI self loop test usin=
g
> > > > tools/spi/spidev_test.c and tried sending `\xDE\xAD\xBE\xEF` and ve=
rified
> > > > it is being received correctly. i updated the of_device_id struct i=
n
> > > > drivers/spi/spi-dw-mmio.c to include "thead,th1520-spi" as the comp=
atible.
> > > > this patch also adds basic spi support on beaglev ahead which share=
s the
> > > > same TH1520 SoC. i have only tested on LicheePi 4A.
> > > >
> > > > Signed-off-by: Kanak Shilledar <kanakshilledar@gmail.com>
> > > > ---
> > > >  .../devicetree/bindings/spi/snps,dw-apb-ssi.yaml |  4 ++++
> > > >  .../boot/dts/thead/th1520-beaglev-ahead.dts      |  9 +++++++++
> > > >  .../boot/dts/thead/th1520-lichee-module-4a.dtsi  |  4 ++++
> > > >  .../riscv/boot/dts/thead/th1520-lichee-pi-4a.dts | 10 ++++++++++
> > > >  arch/riscv/boot/dts/thead/th1520.dtsi            | 16 ++++++++++++=
++++
> > > >  drivers/spi/spi-dw-mmio.c                        |  1 +
> > >
> > > This needs to be 3 different patches - one for the binding, one for t=
he
> > > driver and a final one for the dts files.
> >
> > I will convert this into a patch set of 3 patch as you suggested.
> >
> > > > +
> > > > +&spi0 {
> > > > +     status =3D "okay";
> > > > +     spidev@0 {
> > >
> > > "spidev" is not a type of device, the nodename should match the type.
> > >
> > > > +             compatible =3D "rohm,dh2228fv";
> > > > +             reg =3D <0>;
> > > > +             spi-max-frequency =3D <500000>;
> > > > +     };
> > > > +};
> > >
> > > I'll put money on you not having a dh2228fv on this board. Document w=
hat
> > > you actually have on it please, not what allows you to probe the spid=
ev
> > > driver in linux.
> >
> > Yes, you are right! Actually as per the vendor's kernel it should be a
> > "spi-nor" device from winbond.
> > I changed it to spidev for testing purposes. Shall I just leave it
> > with status =3D "okay" or add the node for
> > that spi-nor flash?
>
> If it isn't on the board, it shouldn't be in the devicetree. Please add
> the actual device that is here instead. If there's a board with nothing
> connected, then please don't add anything.

Alright got it. The SPI flash pad is left unpopulated on the LicheePi 4A bo=
ard.
Thus, I will not mention it in the devicetree.

> Thanks,
> Conor.

Thanks and Regards,
Kanak Shilledar


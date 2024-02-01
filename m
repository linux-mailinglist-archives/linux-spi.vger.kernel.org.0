Return-Path: <linux-spi+bounces-977-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6E3845EA9
	for <lists+linux-spi@lfdr.de>; Thu,  1 Feb 2024 18:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADFA1B229EA
	for <lists+linux-spi@lfdr.de>; Thu,  1 Feb 2024 17:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16A25C036;
	Thu,  1 Feb 2024 17:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnIuqGfQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6E95C033
	for <linux-spi@vger.kernel.org>; Thu,  1 Feb 2024 17:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706809019; cv=none; b=Zwlfb2wmlwYaLB34NdWepkKRHSL79kHF8KO9xep7Mz1G/dYptxV/rhNrzSPT6vZwUR/g4pgBEovONZ9+O/5wE+tbOqyHLkzeDYGsBLhP3NRJOEtftGzWaYwhiXPAJJGhBXbQTduLWa9mnfwAdAtqEyIHX0Rruc90YPjhwK7tXV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706809019; c=relaxed/simple;
	bh=5NKcTj5IM62pSc1LUsVBTp3Fnfs2tU0Bti4D7jMAy7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aWG49en6pWe6zGV7ixTHn/Gr8nXw3+vGZBNqbYcb7yPd6p/L4eYC1j5dIgvXva6veFjb083AL368DHDd01QpCIW6K0TEq47ehx1HYal4QvQVLof8CEXDqKSD6mOfEHM8uPQCzrwti3LguJeXOGLKkledEWaJdRkWF+JCfgguH8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OnIuqGfQ; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a35e65df2d8so157699566b.0
        for <linux-spi@vger.kernel.org>; Thu, 01 Feb 2024 09:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706809016; x=1707413816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Xlusn01LmtrkwThSWnqrsCwa/eQGWR/CrLbSktAMYc=;
        b=OnIuqGfQE1PZaCLFuCCijXe0zVicyNdsTn3RBsGKykn7w+snt8ip4mJ6P5DF6bUebb
         UxUc4DJo9x41sGGdqP3CQe7TKAoGf+nO2qSnS57+Vf2b6WuU3dpg1wbquBoLXATgnhbL
         V+R1yGKoyCgUjB8XIV1D8vIZZW/xpaB9ZcmLNvRTGcsoGR9gCdlvoazADNg/5E+Ywcs5
         dFOXroNQlqCYkd7w/xwSm78nYRJRsvn7pa0z2SHFwqoSOFgeUdbwBU+1QbqWzYkHa8oF
         LX14UvW4uJWmTkROmI4HjDsSw5QaRPwVV05U9X1ugX3srf6ImzX4ngXjnKrgWgdgs+QB
         RoQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706809016; x=1707413816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Xlusn01LmtrkwThSWnqrsCwa/eQGWR/CrLbSktAMYc=;
        b=GpSftS2bEfQVWxYRB6/fKG0t0VluKCW2fN5yKNhBoXD0/NL5eaJNjXt9CEXScMdsgJ
         N344c/1iHYDkH6C6IE0hX5BOzUpWoKY1oSYvCuWkRAp+Qye2EB0jhjffEB2+Wan3rjsL
         iaBZgy0dPrwnAvVTxkt1oNC8RMqBwulAt/RRor5JI7Bnb+G298wL0bJvsDsEcxk1wYw8
         TmiGfmyuaZUt3Xhai4mq1c9RFujd4AN1qSI+mrKugs8ZJNao2RaiNsGyqE+VRAdjjOZ3
         j34cP74dMmMXG79wrUu8ji27kYrwx0Z1zYl/NrFO/ChzPEe7DtP+Swt3H7SlGVOGhTNC
         WQKQ==
X-Gm-Message-State: AOJu0Yw4BCaZ8E9pw4NoeZvq8GsDbN0FAmx8nIZcLt7sLFWl768lb8GM
	sULNxIx536mEQ36o2bLgM42kY/jkirBhTmHAl4kFwrU4nCP8UOnCUjaS2XWQx4+I7UemS/cjZo0
	7XKs3tqhkO6POvSRaqbyR51vpauk=
X-Google-Smtp-Source: AGHT+IE0tWeOBByBmU7tCRwaJfiC5Cy8rMF2fCyPEPe9W+Qd7bo5hSdmO6YwboZe8n8qwWa6HPJjSiP59EcclV+2qXc=
X-Received: by 2002:a17:906:6d41:b0:a35:a4ba:7086 with SMTP id
 a1-20020a1709066d4100b00a35a4ba7086mr3780851ejt.45.1706809015994; Thu, 01 Feb
 2024 09:36:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201172649.794161-1-ckeepax@opensource.cirrus.com>
In-Reply-To: <20240201172649.794161-1-ckeepax@opensource.cirrus.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 1 Feb 2024 19:36:19 +0200
Message-ID: <CAHp75VeUKu4o_ZU0oaL9mnSj3ynTburRyv+=5B7GRqq=wT3w6w@mail.gmail.com>
Subject: Re: [PATCH v2] spi: cs42l43: Clean up of firmware node
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: broonie@kernel.org, patches@opensource.cirrus.com, 
	linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 7:26=E2=80=AFPM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
>
> As we get a child node in the OF case, we should also clean up the
> reference, add code to do so.

...

> +       if (is_of_node(fwnode)) {
> +               fwnode =3D fwnode_get_named_child_node(fwnode, "spi");

> +               devm_add_action(priv->dev, cs42l43_release_of_node, fwnod=
e);

ret =3D ...
if (ret)
  return ret;

> +       }

With that being addressed,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

--=20
With Best Regards,
Andy Shevchenko


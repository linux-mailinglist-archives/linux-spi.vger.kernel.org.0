Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54CE92BFB17
	for <lists+linux-spi@lfdr.de>; Sun, 22 Nov 2020 22:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbgKVVxZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 22 Nov 2020 16:53:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbgKVVxY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 22 Nov 2020 16:53:24 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6F3C0613CF;
        Sun, 22 Nov 2020 13:53:24 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id f23so20642486ejk.2;
        Sun, 22 Nov 2020 13:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:sender:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=holMzMixu6L4mPkY4KLX0AXrH3B7KLU6Q1+gVZ1hbDo=;
        b=iutiWdq2WEjwKxpj8Fj5ahz8hqWjUs7Yyrav4s8v1k/mqlVuPY9u57EzWlP9gcSGF3
         nLPs3vWt6eDKjUyAyzDGiJ/Jqa6RkJ5llsp5y6nXt5CRLAeylDPQrz1F5tCNE07lhUsZ
         DefBtleWej9MfIIZM1hvRfm3Ux1i6AHKnLbmdGLiWiJ7WMsEiW61w/i27REGObWCmji7
         OLu/Eb0Q23U40EbXyc8XsITGej90V/vfvMX8AT3gy2Qnun5LqUzBKJ/YGUAiwGtQ7kav
         nRVnTGlzCZAcjS7hE4ZjsYjkDdGfC4z4F3916iAOaXxz+uSVIJ3Vvfkcf1PsaCQCmNM1
         6Dcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:sender:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=holMzMixu6L4mPkY4KLX0AXrH3B7KLU6Q1+gVZ1hbDo=;
        b=IXt6I+J7Nc0vLKPNaI0weg1X1ZvCZSazbJWw5GbnLOG92hZfp+CyWTY+/ffRZyLI6s
         0otC80EhLlGeqDkyASwaaamGTrYGUE0TzH19+GlBFAiwWgBBSnIilJG1iuo4Ng0rXAqI
         wGaojDxp3Bhp0GhwLRKiBpWo2RaWyBAJI4ztLJbKkwI+cjTYGOyEEcBBRhrkXJn7itwQ
         I1gZENULfYjPExrf3l8ftqY2w22DsYIvg4isZMw/Whv+PrByFY4jXwMfD5RjHXecvUNd
         c54Tm1b7TzON8sPrxWVHeHaW0gPxF1L9Zcml/uZOOwmzz2/K30vYKmiT0azeGkT4tALU
         i88g==
X-Gm-Message-State: AOAM532o9qGsRf3McRo6WQc1pPDBiKpTe7IEKuCKXXGgr/E9PkAeP5Oc
        flzCu8FEZcUv+c0wGsde58I=
X-Google-Smtp-Source: ABdhPJyxEK8hZKHZP/gou5hSHEaspqwGg9FseK29uxduiuNlVG9PatLaZ6TFK8Vy9vnnMcZXOfFZXA==
X-Received: by 2002:a17:906:a194:: with SMTP id s20mr39026886ejy.95.1606082003350;
        Sun, 22 Nov 2020 13:53:23 -0800 (PST)
Received: from [192.168.43.48] ([197.210.35.67])
        by smtp.gmail.com with ESMTPSA id i19sm3978482ejz.71.2020.11.22.13.53.17
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 22 Nov 2020 13:53:22 -0800 (PST)
Message-ID: <5fbaddd2.1c69fb81.9b3f2.1045@mx.google.com>
Sender: Lena Torres <ad482289@gmail.com>
From:   Adelina Zeuki <anglicaramose@gmail.com>
X-Google-Original-From: "Adelina Zeuki" <  adelinazeuki@gmail.comm >
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Hello !!
To:     Recipients <adelinazeuki@gmail.comm>
Date:   Sun, 22 Nov 2020 21:53:11 +0000
Reply-To: adelinazeuki@gmail.com
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi dear,

Can i talk with you ?

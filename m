Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1D5E3051AB
	for <lists+linux-spi@lfdr.de>; Wed, 27 Jan 2021 06:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbhA0FFA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 Jan 2021 00:05:00 -0500
Received: from mail-bn7nam10on2046.outbound.protection.outlook.com ([40.107.92.46]:57696
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231411AbhA0Erf (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 26 Jan 2021 23:47:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JHaRq/gNubuDqzzzc6AmXdQX+f2Y6OiC9o8RvnW6kP9Nx9ttTZJQ6t6Xr5nKnfIva3x0ecDey2WgKenRiQ8DRTWC9piB7E+jHKhFLN3dETPQLXc7kSp4C716Qw9cmvG+4+NPU0wdo0XhqyTxAYbv1FA5HI8+K+wDrhNHsIv3RZZ5pNXjKow4qnSqDJE8vI6ZNKUfeatGZ/zJtQlzBZhk5Xdnqfq4EOOJy/MjDyr8fcQ8uNg1EJs2PfcINlFsuH4IYa/CWTlUwLPemHhMQBWHJJp6MzV9K6GIe8FIHnphaDy1Yk0YgpJ1ttspd71b6uUpxfFg4kQPsPq/Q/9g7ABdhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nVHTN6SXQBasE1NNhU+jO3l4ONyDUBVePYQWDYMu+ys=;
 b=n6ywN58EEZ9MsdbUEnDNuJsPxXoiVhl8bebuhekqn2PPE6bZOEZ2z2pVxOVFOm3AeXRaNe/vqtvaZiDS4tyt9LWTQ3HXf3ZMofUjKUptlPG/rxUpqkIqZhsQOcpL9GF5WF+t/dYmfroo8WcVxsXFGgrW5WbJqv8AyNeZeKIzAK1SA5HLWHHwV6CpPvlpwcdRPDJJYVPT+s971fij0IZaTfiqTovd/ceS4oFcf5HzZ2yEXCl339SNxGbM2p4s1eC2A/wJTTNSOV8fEqmtyxi6ryXWlW2lUi/Eq+L+l4MXyjuUqKIJz7qm43/f873VTHAmWG8nk/Jx044l/tt/s9H1Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nVHTN6SXQBasE1NNhU+jO3l4ONyDUBVePYQWDYMu+ys=;
 b=SDrr0PfmbGVIEpkv1fglP6ZfimvGQ6q5H9TX/tq6H8rvorRToGBmmXOunMDgLSi3dMH7DLGPy6C9BtIO2ftm7hRcipYL6FpeNiuMrdwcAFT7rplRtvuHeva27a5OdLC9lRa1UCQVmuE9xhrR6RupwVbd8ITIbjsDoVzOuZY+jkQ=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4127.namprd12.prod.outlook.com (2603:10b6:208:1d1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Wed, 27 Jan
 2021 04:46:40 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%6]) with mapi id 15.20.3763.019; Wed, 27 Jan 2021
 04:46:40 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Corentin Chary <corentin.chary@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "acpi4asus-user@lists.sourceforge.net" 
        <acpi4asus-user@lists.sourceforge.net>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: RE: [PATCH] ACPI: Test for ACPI_SUCCESS rather than !ACPI_FAILURE
Thread-Topic: [PATCH] ACPI: Test for ACPI_SUCCESS rather than !ACPI_FAILURE
Thread-Index: AQHW9CEa0TospenDMUOKMvLoLeXOnao65hRw
Date:   Wed, 27 Jan 2021 04:46:39 +0000
Message-ID: <MN2PR12MB44887C0B80BE4E74DAAD7712F7BB0@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20210126202317.2914080-1-helgaas@kernel.org>
In-Reply-To: <20210126202317.2914080-1-helgaas@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-01-27T04:46:34Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=b6e609d1-e788-41ac-84b2-0000b0d8c7a3;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2021-01-27T04:46:27Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 6262156f-5ca0-4436-acdb-00004a4c3923
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2021-01-27T04:46:36Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 5b2e73a1-3424-4c79-b2c8-0000b87650fd
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.66.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7242b501-e44b-4a8e-76f3-08d8c27e896d
x-ms-traffictypediagnostic: MN2PR12MB4127:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB41273E72C0EAA8BBD52F5FAAF7BB9@MN2PR12MB4127.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U7EYK2p5cao/l+G4O8bN4pyf/mh1vNLFEvIUA1mhdS8V4IZtvxxLp7MeRtjHrQkNhHfKp9CjvCtgLygFp2vEUJ5Ihwyzspv9EXCOAlvThLgzqBrHreBk4r7rapnF4DKkjfzIOqqp8PhEvJxLXZJR1OPFRhxpKEGYp62HtenrH6xgeFWvPu0Aut/0gIcHhyZz0VFmNcZGVB41t7iS7kWlfJRru9Sr3Ibvg5e8guU9mL2PnpB2kaPXLbkt3jmL049xjy8XOZzWwXsLfBTE2SimD+RQtmGvSuehWfpavHMD8H1XLHnjKyMnC1+G+y4Il7lv9IW7a6ynpm9VNAp9m8ET9nOE/tZYa6aoDkEly+9CHT2i12IV36X1erUNj6aSeCuUDL4zlvlbxnNP5feCAgHJ+oiXIwwET9WlvufaCnLCHVgJXEfNNeB4pAoMzaq1M/pBTjirMtSOJk/1cVsei5iVUg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4488.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(478600001)(71200400001)(83380400001)(186003)(33656002)(66446008)(316002)(53546011)(76116006)(8676002)(8936002)(26005)(86362001)(2906002)(7416002)(6506007)(5660300002)(110136005)(55016002)(66556008)(64756008)(66476007)(52536014)(9686003)(66946007)(7696005)(54906003)(921005)(4326008)(46800400006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?8ucgcD/j5Q2CIfTgzYgDZKeXQq5fC1GIpn2Ag7kf0TrP7Lm2MpMu//wVoa5N?=
 =?us-ascii?Q?VYZAPUS0kLgGPnZnzm96ULGZznhhZvF/eTeJa3mtAVUzq4yymPbGUsnMIJIj?=
 =?us-ascii?Q?ooczaPq6OFi6K8tLDNancA78JfsZX+6TyVe/7RNNQOSzxLGG6Q22xNepVBtk?=
 =?us-ascii?Q?U4V74qzg+WfedQY5U/7S4hpQSMdwoTGy2/bbsELmcckvfF19o4BxM6B+YMOP?=
 =?us-ascii?Q?YP3sk7A4SEiyQUppy5dJpW5GUipxk6NXRFOGO5xuft1N4vfgUxSLH5A02jy8?=
 =?us-ascii?Q?BXeyGHFjeiPay9U99tmMVQoSnPWbo9j3ErGa+4fHRHzuCyQxZMnAvdyHZYJC?=
 =?us-ascii?Q?wnExpecHF/BxyHGH7C52WqfSb0IdmXqMLrHP96RnwG9kDdBA95aj62hbBKMk?=
 =?us-ascii?Q?J8tXJfYyTXqAu5l9BkS6mk421sbMF4l09tGEr/GZNTzuoMqZIm7uZNWHZkk4?=
 =?us-ascii?Q?sTTbih5d4DOaEQ9dC/8XFjZaFs3MAWWf/B1T4INcbNx6m2XRL5EaQsisYRvO?=
 =?us-ascii?Q?41oE9XYkvVikJlaJQCZe5ivQMk8siucuL823IuhrG6FRraPLwluFail+hYYe?=
 =?us-ascii?Q?tUDPMRnBHxpjX6WdMoTkHVFOZOTwAZcVTe08wxbe0Y62vKI9q5OtrQuBCMY6?=
 =?us-ascii?Q?PMwGSjyBXxCslZ+JGhpyQ7FaaaXOz2+4oazX5nzbyW837co68nieDLbjnlaM?=
 =?us-ascii?Q?yk1FAltST1huBrZOl2D5uB/7/3k7fCeMyi8UciWih3Tct3C/mo8T+FrunhdK?=
 =?us-ascii?Q?beMScss2UpuddWGthH1Sw3AORnEaxbfY1AqhbM44O56GD0ryVF81Y1N+TGu3?=
 =?us-ascii?Q?C6CNFXRLeJgxniiRyteUamZzwvuLccEmWYTW8WBXFLsUWTi2grPU6hDTY/ZV?=
 =?us-ascii?Q?ju+COQHfpFedkfqIJwFnbqW8sCmD5xnzVJre3zTqgILmOd8dMaNd64d/IQ1G?=
 =?us-ascii?Q?TICmxfiCxxlFy2QpJh+mGl97AYDS1lJcdpaTXi9WRR0DvIYnS5/3m4+qsshD?=
 =?us-ascii?Q?TqAnSP6w/vMJXFa/8n6xQYV+ydkmJ5v7tUTH5s90+clWR45MavnMQKhK6LKL?=
 =?us-ascii?Q?avgYo15Q?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7242b501-e44b-4a8e-76f3-08d8c27e896d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2021 04:46:39.6910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wYxdZuD2WdzQtFxXmvokOadjHQpbMgheeg0HBZiFBWxX0tkATa1SE4x9GY+bPTfQ8EsgvxRRKQ9knOet4ADk6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4127
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

[AMD Public Use]

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Tuesday, January 26, 2021 3:23 PM
> To: Rafael J . Wysocki <rjw@rjwysocki.net>; Len Brown <lenb@kernel.org>;
> Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Jean Delvare <jdelvare@suse.com>; Guenter
> Roeck <linux@roeck-us.net>; Corentin Chary <corentin.chary@gmail.com>;
> Mark Brown <broonie@kernel.org>; Jaroslav Kysela <perex@perex.cz>;
> Takashi Iwai <tiwai@suse.com>
> Cc: linux-spi@vger.kernel.org; acpi4asus-user@lists.sourceforge.net; linu=
x-
> hwmon@vger.kernel.org; amd-gfx@lists.freedesktop.org; alsa-devel@alsa-
> project.org; linux-acpi@vger.kernel.org; Bjorn Helgaas
> <bhelgaas@google.com>
> Subject: [PATCH] ACPI: Test for ACPI_SUCCESS rather than !ACPI_FAILURE
>=20
> From: Bjorn Helgaas <bhelgaas@google.com>
>=20
> The double negative makes it hard to read "if (!ACPI_FAILURE(status))".
> Replace it with "if (ACPI_SUCCESS(status))".
>=20
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>=20
> This isn't really an ACPI patch, but I'm sending it to you, Rafael, since=
 it seems
> easier to just apply these all at once.  But I'd be happy to split them u=
p into
> individual patches if you'd rather.
>=20
>=20
>  drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 4 ++--
>  drivers/gpu/drm/radeon/radeon_bios.c     | 4 ++--

For radeon and amdgpu:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

>  drivers/hwmon/acpi_power_meter.c         | 4 ++--
>  drivers/platform/x86/asus-laptop.c       | 6 +++---
>  drivers/spi/spi.c                        | 2 +-
>  sound/pci/hda/hda_intel.c                | 4 ++--
>  6 files changed, 12 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> index 6333cada1e09..055f600eeed8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> @@ -291,7 +291,7 @@ static bool amdgpu_atrm_get_bios(struct
> amdgpu_device *adev)
>  			continue;
>=20
>  		status =3D acpi_get_handle(dhandle, "ATRM", &atrm_handle);
> -		if (!ACPI_FAILURE(status)) {
> +		if (ACPI_SUCCESS(status)) {
>  			found =3D true;
>  			break;
>  		}
> @@ -304,7 +304,7 @@ static bool amdgpu_atrm_get_bios(struct
> amdgpu_device *adev)
>  				continue;
>=20
>  			status =3D acpi_get_handle(dhandle, "ATRM",
> &atrm_handle);
> -			if (!ACPI_FAILURE(status)) {
> +			if (ACPI_SUCCESS(status)) {
>  				found =3D true;
>  				break;
>  			}
> diff --git a/drivers/gpu/drm/radeon/radeon_bios.c
> b/drivers/gpu/drm/radeon/radeon_bios.c
> index bb29cf02974d..43bbbfd6ade8 100644
> --- a/drivers/gpu/drm/radeon/radeon_bios.c
> +++ b/drivers/gpu/drm/radeon/radeon_bios.c
> @@ -205,7 +205,7 @@ static bool radeon_atrm_get_bios(struct
> radeon_device *rdev)
>  			continue;
>=20
>  		status =3D acpi_get_handle(dhandle, "ATRM", &atrm_handle);
> -		if (!ACPI_FAILURE(status)) {
> +		if (ACPI_SUCCESS(status)) {
>  			found =3D true;
>  			break;
>  		}
> @@ -218,7 +218,7 @@ static bool radeon_atrm_get_bios(struct
> radeon_device *rdev)
>  				continue;
>=20
>  			status =3D acpi_get_handle(dhandle, "ATRM",
> &atrm_handle);
> -			if (!ACPI_FAILURE(status)) {
> +			if (ACPI_SUCCESS(status)) {
>  				found =3D true;
>  				break;
>  			}
> diff --git a/drivers/hwmon/acpi_power_meter.c
> b/drivers/hwmon/acpi_power_meter.c
> index 848718ab7312..7d3ddcba34ce 100644
> --- a/drivers/hwmon/acpi_power_meter.c
> +++ b/drivers/hwmon/acpi_power_meter.c
> @@ -161,7 +161,7 @@ static ssize_t set_avg_interval(struct device *dev,
>  	mutex_lock(&resource->lock);
>  	status =3D acpi_evaluate_integer(resource->acpi_dev->handle, "_PAI",
>  				       &args, &data);
> -	if (!ACPI_FAILURE(status))
> +	if (ACPI_SUCCESS(status))
>  		resource->avg_interval =3D temp;
>  	mutex_unlock(&resource->lock);
>=20
> @@ -232,7 +232,7 @@ static ssize_t set_cap(struct device *dev, struct
> device_attribute *devattr,
>  	mutex_lock(&resource->lock);
>  	status =3D acpi_evaluate_integer(resource->acpi_dev->handle,
> "_SHL",
>  				       &args, &data);
> -	if (!ACPI_FAILURE(status))
> +	if (ACPI_SUCCESS(status))
>  		resource->cap =3D temp;
>  	mutex_unlock(&resource->lock);
>=20
> diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/as=
us-
> laptop.c
> index 0edafe687fa9..bfea656e910c 100644
> --- a/drivers/platform/x86/asus-laptop.c
> +++ b/drivers/platform/x86/asus-laptop.c
> @@ -861,7 +861,7 @@ static ssize_t infos_show(struct device *dev, struct
> device_attribute *attr,
>  	 * The significance of others is yet to be found.
>  	 */
>  	rv =3D acpi_evaluate_integer(asus->handle, "SFUN", NULL, &temp);
> -	if (!ACPI_FAILURE(rv))
> +	if (ACPI_SUCCESS(rv))
>  		len +=3D sprintf(page + len, "SFUN value         : %#x\n",
>  			       (uint) temp);
>  	/*
> @@ -873,7 +873,7 @@ static ssize_t infos_show(struct device *dev, struct
> device_attribute *attr,
>  	 * takes several seconds to run on some systems.
>  	 */
>  	rv =3D acpi_evaluate_integer(asus->handle, "HWRS", NULL, &temp);
> -	if (!ACPI_FAILURE(rv))
> +	if (ACPI_SUCCESS(rv))
>  		len +=3D sprintf(page + len, "HWRS value         : %#x\n",
>  			       (uint) temp);
>  	/*
> @@ -884,7 +884,7 @@ static ssize_t infos_show(struct device *dev, struct
> device_attribute *attr,
>  	 * silently ignored.
>  	 */
>  	rv =3D acpi_evaluate_integer(asus->handle, "ASYM", NULL, &temp);
> -	if (!ACPI_FAILURE(rv))
> +	if (ACPI_SUCCESS(rv))
>  		len +=3D sprintf(page + len, "ASYM value         : %#x\n",
>  			       (uint) temp);
>  	if (asus->dsdt_info) {
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c index
> 720ab34784c1..801d8b499788 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -2210,7 +2210,7 @@ static acpi_status acpi_register_spi_device(struct
> spi_controller *ctlr,
>  		return AE_OK;
>=20
>  	if (!lookup.max_speed_hz &&
> -	    !ACPI_FAILURE(acpi_get_parent(adev->handle, &parent_handle))
> &&
> +	    ACPI_SUCCESS(acpi_get_parent(adev->handle, &parent_handle))
> &&
>  	    ACPI_HANDLE(ctlr->dev.parent) =3D=3D parent_handle) {
>  		/* Apple does not use _CRS but nested devices for SPI slaves
> */
>  		acpi_spi_parse_apple_properties(adev, &lookup); diff --git
> a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c index
> 770ad25f1907..fe8049cd2765 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -1444,7 +1444,7 @@ static bool atpx_present(void)
>  		dhandle =3D ACPI_HANDLE(&pdev->dev);
>  		if (dhandle) {
>  			status =3D acpi_get_handle(dhandle, "ATPX",
> &atpx_handle);
> -			if (!ACPI_FAILURE(status)) {
> +			if (ACPI_SUCCESS(status)) {
>  				pci_dev_put(pdev);
>  				return true;
>  			}
> @@ -1454,7 +1454,7 @@ static bool atpx_present(void)
>  		dhandle =3D ACPI_HANDLE(&pdev->dev);
>  		if (dhandle) {
>  			status =3D acpi_get_handle(dhandle, "ATPX",
> &atpx_handle);
> -			if (!ACPI_FAILURE(status)) {
> +			if (ACPI_SUCCESS(status)) {
>  				pci_dev_put(pdev);
>  				return true;
>  			}
> --
> 2.25.1
